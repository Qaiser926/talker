import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/utils.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:seamstress/profil/constant/getstorage.dart';
import 'package:seamstress/profil/rewordAds.dart';
import 'package:seamstress/profil/subscriptionModelClass.dart';

import '../backend/stripe/payment_manager.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:onepref/onepref.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
class SubscriptionPageWidget extends StatefulWidget {
  const SubscriptionPageWidget({Key? key}) : super(key: key);

  @override
  _SubscriptionPageWidgetState createState() => _SubscriptionPageWidgetState();
}

class _SubscriptionPageWidgetState extends State<SubscriptionPageWidget> {
  late SubscriptionPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

// list 

    late final List<ProductDetails> _products=<ProductDetails>[];


   
// iApEngine
IApEngine iApEngine = IApEngine();
// lsit of product id;

  List<ProductId> storeProductIds=<ProductId>[
     
    ProductId(id:"coin_30", isConsumable: true , reward: 30),
    ProductId(id:"coin_500", isConsumable: true , reward: 500),
    ProductId(id:"coin_100", isConsumable: true , reward: 100),
    ProductId(id:"coin_143230", isConsumable: true , reward: 100),
    ProductId(id:"coin_40", isConsumable: true , reward: 200),
  ];

  int reward=0;
  
  @override
  void initState() {
    super.initState();
 
    iApEngine.inAppPurchase.purchaseStream.listen((list){
    listenPurchases(list);
    });
       getProduct();


       reward=OnePref.getInt('coins')??0;

  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }


 bool isLightTheme = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    // context.watch<FFAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("$reward"),
      ),
      body:Center(
          child: TextButton(
              onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => UsePaypal(
                            sandboxMode: true,
                            clientId:
                                "AZP8nBCBu81unHeTe5HYHHzg8y2sRGB7FvE59nIDzh2SwCkFt2ZfPGw7EVvpLpT6gx5gPzCwoWP6_KSk",
                            secretKey:
                                "EGzRIBUdm-ruQ5nUDIRZdlvY3UxlIdDOEyeU3qD2AP5yJbhxBss-6EtTb7oaCDxZ8snkiJDMVioYFR8A",
                            returnURL: "https://samplesite.com/return",
                            // sb-qrpxw29274525@business.example.com     send box account
                            // access_token$sandbox$vpb2f2j36qh2857b$096239e89fd9d7ce702d8de96fca5258 access token
                            cancelURL: "https://samplesite.com/cancel",
                            transactions: const [
                              {
                                "amount": {
                                  "total": '10.12',
                                  "currency": "USD",
                                  "details": {
                                    "subtotal": '10.12',
                                    "shipping": '0',
                                    "shipping_discount": 0
                                  }
                                },
                                "description":
                                    "The payment transaction description.",
                                // "payment_options": {
                                //   "allowed_payment_method":
                                //       "INSTANT_FUNDING_SOURCE"
                                // },
                                "item_list": {
                                  "items": [
                                    {
                                      "name": "A demo product",
                                      "quantity": 1,
                                      "price": '10.12',
                                      "currency": "USD"
                                    }
                                  ],

                                  // shipping address is not required though
                                  "shipping_address": {
                                    "recipient_name": "Jane Foster",
                                    "line1": "Travis County",
                                    "line2": "",
                                    "city": "Austin",
                                    "country_code": "US",
                                    "postal_code": "73301",
                                    "phone": "+00000000",
                                    "state": "Texas"
                                  },
                                }
                              }
                            ],
                            note: "Contact us for any questions on your order.",
                            onSuccess: (Map params) async {
                              print("onSuccess: $params");
                            },
                            onError: (error) {
                              print("onError: $error");
                            },
                            onCancel: (params) {
                              print('cancelled: $params');
                            }),
                      ),
                    )
                  },
              child: const Text("Make Payment")),
        )
      /*  
            Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: ExactAssetImage(
              //       isLightTheme ? 'icons/bg-light.png' : 'icons/bg-dark.png',
              //     ),
              //     fit: BoxFit.fill,
              //   ),
              // ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // IconButton(
                    //   onPressed: () => setState(() {
                    //     isLightTheme = !isLightTheme;
                    //   }),
                    //   icon: Icon(
                    //     isLightTheme ? Icons.light_mode : Icons.dark_mode,
                    //   ),
                    // ),
                    CreditCardWidget(
                      enableFloatingCard: useFloatingAnimation,
                      glassmorphismConfig: _getGlassmorphismConfig(),
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      bankName: 'Axis Bank',
                      frontCardBorder: useGlassMorphism
                          ? null
                          : Border.all(color: Colors.grey),
                      backCardBorder: useGlassMorphism
                          ? null
                          : Border.all(color: Colors.grey),
                      showBackView: isCvvFocused,
                      obscureCardNumber: true,
                      obscureCardCvv: true,
                      isHolderNameVisible: true,
                      cardBgColor: isLightTheme
                          ? AppColors.cardBgLightColor
                          : AppColors.cardBgColor,
                      backgroundImage:
                          useBackgroundImage ? 'icons/card_bg.png' : null,
                      isSwipeGestureEnabled: true,
                      onCreditCardWidgetChange:
                          (CreditCardBrand creditCardBrand) {},
                      customCardTypeIcons: <CustomCardTypeIcon>[
                        CustomCardTypeIcon(
                          cardType: CardType.mastercard,
                          cardImage: Image.asset(
                            'icons/mastercard.png',
                            height: 48,
                            width: 48,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            CreditCardForm(
                              formKey: formKey,
                              obscureCvv: true,
                              obscureNumber: true,
                              cardNumber: cardNumber,
                              cvvCode: cvvCode,
                              isHolderNameVisible: true,
                              isCardNumberVisible: true,
                              isExpiryDateVisible: true,
                              cardHolderName: cardHolderName,
                              expiryDate: expiryDate,
                              inputConfiguration: const InputConfiguration(
                                cardNumberDecoration: InputDecoration(
                                  labelText: 'Number',
                                  hintText: 'XXXX XXXX XXXX XXXX',
                                ),
                                expiryDateDecoration: InputDecoration(
                                  labelText: 'Expired Date',
                                  hintText: 'XX/XX',
                                ),
                                cvvCodeDecoration: InputDecoration(
                                  labelText: 'CVV',
                                  hintText: 'XXX',
                                ),
                                cardHolderDecoration: InputDecoration(
                                  labelText: 'Card Holder',
                                ),
                              ),
                              onCreditCardModelChange: onCreditCardModelChange,
                            ),
                            const SizedBox(height: 20),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 16),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: <Widget>[
                            //       const Text('Glassmorphism'),
                            //       const Spacer(),
                            //       Switch(
                            //         value: useGlassMorphism,
                            //         inactiveTrackColor: Colors.grey,
                            //         activeColor: Colors.white,
                            //         activeTrackColor: AppColors.colorE5D1B2,
                            //         onChanged: (bool value) => setState(() {
                            //           useGlassMorphism = value;
                            //         }),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 16),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: <Widget>[
                            //       const Text('Card Image'),
                            //       const Spacer(),
                            //       Switch(
                            //         value: useBackgroundImage,
                            //         inactiveTrackColor: Colors.grey,
                            //         activeColor: Colors.white,
                            //         activeTrackColor: AppColors.colorE5D1B2,
                            //         onChanged: (bool value) => setState(() {
                            //           useBackgroundImage = value;
                            //         }),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 16),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: <Widget>[
                            //       const Text('Floating Card'),
                            //       const Spacer(),
                            //       Switch(
                            //         value: useFloatingAnimation,
                            //         inactiveTrackColor: Colors.grey,
                            //         activeColor: Colors.white,
                            //         activeTrackColor: AppColors.colorE5D1B2,
                            //         onChanged: (bool value) => setState(() {
                            //           useFloatingAnimation = value;
                            //         }),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: _onValidate,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  // gradient: LinearGradient(
                                  //   colors: <Color>[
                                  //     AppColors.colorB58D67,
                                  //     AppColors.colorB58D67,
                                  //     AppColors.colorE5D1B2,
                                  //     AppColors.colorF9EED2,
                                  //     AppColors.colorEFEFED,
                                  //     AppColors.colorF9EED2,
                                  //     AppColors.colorB58D67,
                                  //   ],
                                  //   begin: Alignment(-1, -4),
                                  //   end: Alignment(1, 4),
                                  // ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Validate',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'halter',
                                    fontSize: 14,
                                    package: 'flutter_credit_card',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
      
      */
      // ListView.builder(
      //   itemCount: _products.length,
      //   itemBuilder: (context, index) {
      //     return Container(

      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         boxShadow: [
      //         BoxShadow(
      //           blurRadius: 10,
      //           color: Colors.grey.shade200,
      //           offset: Offset(0, 0),
      //           spreadRadius: 14
      //         )
      //         ]
      //       ),
      //       child: GestureDetector(
      //         onTap: ()async =>{
      //            iApEngine.handlePurchase(
                  
      //             _products[index], storeProductIds)
      //         },
      //         child: ListTile( 
                       
      //           title: Text(_products[index].description, style: TextStyle(fontWeight: FontWeight.bold),),
      //          trailing: Text(_products[index].price),
      //         ),
      //       ),
      //     ).paddingAll(10);
          
      //   },
      // ),
    
    );
  }

  void _onValidate() {
    if (formKey.currentState?.validate() ?? false) {
      print('valid!');
    } else {
      print('invalid!');
    }
  }

  Glassmorphism? _getGlassmorphismConfig() {
    if (!useGlassMorphism) {
      return null;
    }

    final LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Colors.grey.withAlpha(50), Colors.grey.withAlpha(50)],
      stops: const <double>[0.3, 0],
    );

    return isLightTheme
        ? Glassmorphism(blurX: 8.0, blurY: 16.0, gradient: gradient)
        : Glassmorphism.defaultConfig();
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
   void  getProduct()async{
    await iApEngine.getIsAvailable().then((value) async{
      if(value){
        await iApEngine.queryProducts(
          
          storeProductIds).then((response) {
          print("response is : T${response.notFoundIDs}"); 
          setState((){
            _products.addAll(response.productDetails);
          });
        });
      }
    });
   }


Future<void> listenPurchases(List<PurchaseDetails> list)async{


   for(PurchaseDetails purchase in list){

    if(purchase.status==PurchaseStatus.restored ||
    purchase.status==PurchaseStatus.purchased
    ){
      if(Platform.isAndroid && iApEngine.getProductIdsOnly(storeProductIds).contains(purchase.productID)){
        final InAppPurchaseAndroidPlatformAddition androidAddition=iApEngine
        .inAppPurchase
        .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      } 
      if(purchase.pendingCompletePurchase){
        await iApEngine.inAppPurchase.completePurchase(purchase);
      }
      // delivery the product
giveUserCoins(purchase);

    }
    
   }

}
void giveUserCoins(PurchaseDetails purchaseDetails){

  reward= OnePref.getInt('coins')??0;
  
   for(var product in storeProductIds){
    if(product.id==purchaseDetails.productID){
      setState((){

        reward=reward + product.reward!;
        OnePref.setInt('coins', reward);
      });
    }
   }
}
}


class AppColors {
  AppColors._();

  static const Color cardBgColor = Color(0xff363636);
  static const Color cardBgLightColor = Color(0xff999999);
  static const Color colorB58D67 = Color(0xffB58D67);
  static const Color colorE5D1B2 = Color(0xffE5D1B2);
  static const Color colorF9EED2 = Color(0xffF9EED2);
  static const Color colorEFEFED = Color(0xffEFEFED);
}
