// import 'dart:math';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/number_symbols_data.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';

import '../../flutter_flow/flutter_flow_widgets.dart';
import '../cloud_functions/cloud_functions.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

final _isProd = false;

// Stripe Credentials
const _kProdStripePublishableKey = '';
const _kTestStripePublishableKey =
    'pk_test_51O51RSLjbADrFNeFAt0oAHdZvPqADfdgFZCuJBAC9CweZJMXo1oiojcTOxXL6c7K5OaAR6J6z82s5gHxf3I1uE1200Bl6ESq6b';
const _kAppleMerchantId = '';

String stripePublishableKey() =>
    _isProd ? _kProdStripePublishableKey : _kTestStripePublishableKey;
String merchantIdentifier() => isAndroid ? '' : _kAppleMerchantId;

Future initializeStripe() async {
  Stripe.publishableKey = stripePublishableKey();
  if (merchantIdentifier().isNotEmpty) {
    Stripe.merchantIdentifier = merchantIdentifier();
  }
  await Stripe.instance.applySettings();
}

class StripePaymentResponse {
  const StripePaymentResponse({this.paymentId, this.errorMessage});
  final String? paymentId;
  final String? errorMessage;
}

Future<StripePaymentResponse> processStripePayment(
  BuildContext context, {
  required num amount,
  required String currency,
  required String customerEmail,
  String customerName = '',
  String description = '',
  bool allowGooglePay = true,
  bool allowApplePay = false,
  ThemeMode themeStyle = ThemeMode.system,
  Color? buttonColor,
  Color? buttonTextColor,
})
async {
  try {
    final callName = _isProd ? 'initStripePayment' : 'initStripeTestPayment';
    final response = await makeCloudCall(
      callName,
      {
        'amount': amount.round(),
        'currency': currency,
        'email': customerEmail,
        'name': customerName,
        'description': description,
      },
    );
    final success = response['success']??false;
    if (!success || !response.containsKey('paymentId')) {
      return StripePaymentResponse(

          errorMessage: response['error'] ?? 'Unknown error occurred');

    }

    /// For web, display a payment sheet with a credit card form.
    if (kIsWeb) {
      return showWebPaymentSheet(
        context,
        paymentId: response['paymentId'],
        paymentIntentSecret: response['paymentIntent'],
        amount: amount,
        currency: currency,
        description: description,
        buttonColor: buttonColor,
        buttonTextColor: buttonTextColor,
        themeStyle: themeStyle,
      );
    }

    /// For mobile, use the native Stripe payment sheet to pay.
    ///
    /// First, initialize payment using the Stripe payment sheet.
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: response['paymentIntent'],
        customerEphemeralKeySecret: response['ephemeralKey'],
        customerId: response['customer'],
        merchantDisplayName: 'Programmer',
        googlePay: allowGooglePay
            ? PaymentSheetGooglePay(
                merchantCountryCode: 'PK',
                currencyCode: currency,
                testEnv: !_isProd,
              )
            : null,
        applePay: isiOS && allowApplePay
            ? PaymentSheetApplePay(
                merchantCountryCode: 'PK',
              )
            : null,
        style: themeStyle,
        appearance: PaymentSheetAppearance(
          primaryButton: PaymentSheetPrimaryButtonAppearance(
            colors: PaymentSheetPrimaryButtonTheme(
              light: PaymentSheetPrimaryButtonThemeColors(
                background: buttonColor,
                text: buttonTextColor,
              ),
              dark: PaymentSheetPrimaryButtonThemeColors(
                background: buttonColor,
                text: buttonTextColor,
              ),
            ),
          ),
        ),
      ),
    );

    /// Then show the payment sheet and confirm payment.
    await Stripe.instance.presentPaymentSheet();

    /// Finally, return the completed payment id to for record keeping.
    return StripePaymentResponse(paymentId: response['paymentId']);
  } catch (e) {
    if (e is StripeException && e.error.code == FailureCode.Canceled) {
      return StripePaymentResponse();
    }
    return StripePaymentResponse(errorMessage: ' Qaiser ${e.toString()}');
  }
}


Map<String, dynamic>? paymentIntent;
Future<void> makePayment(BuildContext context) async {
  try {
    paymentIntent = await createPaymentIntent('10', 'USD');
    //Payment Sheet
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
            // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
            style: ThemeMode.dark,
            merchantDisplayName: 'programmer')).then((value){
    });
    // pi_3O6oPHAH1gtFrfMT2JYnpdmD_secret_fknxQXngcFGvqU3TJKnmIrE9F

    ///now finally display payment sheeet
    displayPaymentSheet(context);
  } catch (e, s) {
    print('ye first error he :${e.toString()} ye b error he  ${s.toString()}');
  }
}

displayPaymentSheet(BuildContext context) async {

  try {
    await Stripe.instance.presentPaymentSheet(
    ).then((value){
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green,),
                    Text("Payment Successfull"),
                  ],
                ),
              ],
            ),
          ));
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

      paymentIntent = null;

    }).onError((error, stackTrace){
      log('Error is:--->$error $stackTrace');
    });


  } on StripeException catch (e) {
    // log('Error is:---> $e');
    log('Error is : ${e.toString()}');
    showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Cancelled "),
        ));
  } catch (e) {
    log('${e.toString()}');
  }
}

//  Future<Map<String, dynamic>>
createPaymentIntent(String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card'
    };

    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer sk_test_51NGSWdAH1gtFrfMTWCmkzyRdSuFjDWh5jI4GS41D3AFT4yaoVZZ1xT8MQjFyL8OplF86ysRYqITtEXnAT9koZXgN00F96axu3T',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );
    // ignore: avoid_print
    log('Payment Intent Body->>> ${response.body.toString()}');
    return jsonDecode(response.body);
  } catch (err) {
    // ignore: avoid_print
    log('err charging user: ${err.toString()}');
  }
}

calculateAmount(String amount) {
  final calculatedAmout = (int.parse(amount)) * 100 ;
  return calculatedAmout.toString();
}



// yaha tak
Future<StripePaymentResponse> showWebPaymentSheet(
  BuildContext context, {
  required String paymentId,
  required String paymentIntentSecret,
  required num amount,
  required String currency,
  required String description,
  Color? buttonColor,
  Color? buttonTextColor,
  ThemeMode? themeStyle,
}) async {
  final isDarkMode = themeStyle == null
      ? Theme.of(context).brightness == Brightness.dark
      : themeStyle == ThemeMode.dark;
  buttonColor = buttonColor ?? FlutterFlowTheme.of(context).primary;
  final screenWidth = MediaQuery.sizeOf(context).width;

  final buildPaymentSheet = (BuildContext context, double width) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: width,
                padding: const EdgeInsets.fromLTRB(24.0, 14.0, 24.0, 24.0),
                color: isDarkMode ? Color(0xFF101213) : Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Payment Information',
                                style: GoogleFonts.outfit(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Color(0xFF101213),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 22,
                                  color: isDarkMode
                                      ? Color(0xFF95A1AC)
                                      : Color(0xFF57636C),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (description.isNotEmpty) ...[
                          const SizedBox(height: 8.0),
                          Text(
                            description,
                            style: GoogleFonts.outfit(
                              color: isDarkMode
                                  ? Color(0xFF95A1AC)
                                  : Color(0xFF57636C),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    CardField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: buttonColor!,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Color(0xFF22282F)
                                : Color(0xFFE0E3E7),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fillColor: Color(0xFFF1F4F8),
                        filled: isDarkMode,
                      ),
                      style: GoogleFonts.outfit(
                        color: isDarkMode ? Colors.white : Color(0xFF101213),
                        fontSize: 14,
                      ),
                      // enablePostalCode: true,
                    ),
                    const SizedBox(height: 20.0),
                    // FFButtonWidget(
                    //   onPressed: () async {
                    //     final response = await Stripe.instance.confirmPayment(
                    //       paymentIntentClientSecret: paymentIntentSecret,
                    //       data: PaymentMethodParams.card(
                    //         paymentMethodData: PaymentMethodData(),
                    //       ),
                    //       options: PaymentMethodOptions(),
                    //     );
                    //     if (response.status == PaymentIntentsStatus.Succeeded) {
                    //       Navigator.pop(
                    //         context,
                    //         StripePaymentResponse(paymentId: paymentId),
                    //       );
                    //     }
                    //   },
                    //   // text:
                    //   //     'Pay ${_displayAmount(currency, amount.toDouble())}',
                    //   options: FFButtonOptions(
                    //     width: double.infinity,
                    //     height: 44,
                    //     color: buttonColor,
                    //     textStyle: GoogleFonts.outfit(
                    //       color: buttonTextColor ?? Colors.white,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //     elevation: 2,
                    //     borderSide: BorderSide(
                    //       color: Colors.transparent,
                    //       width: 1,
                    //     ),
                    //     borderRadius: BorderRadius.circular(6),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  final response = await showDialog<StripePaymentResponse>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: buildPaymentSheet(context, min(420, screenWidth - 16)),
    ),
  );
  // Return the payment response, or an empty response if the user canceled.
  return response ?? StripePaymentResponse();
}

// String _displayAmount(String currency, double amount) {
//   final digitFractions = currencyFractionDigits[currency.toUpperCase()] ?? 2;
//   amount /= pow(10, digitFractions);
//   return NumberFormat.simpleCurrency(name: currency).format(amount);
// }
