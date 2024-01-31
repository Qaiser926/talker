import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constant/admobKey.dart';
import '../profil/rewordAds.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'page_accueil_model.dart';
export 'page_accueil_model.dart';

class PageAccueilWidget extends StatefulWidget {
  const PageAccueilWidget({Key? key}) : super(key: key);

  @override
  _PageAccueilWidgetState createState() => _PageAccueilWidgetState();
}

class _PageAccueilWidgetState extends State<PageAccueilWidget> {
  late PageAccueilModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PageAccueilModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));

  }
  RewardedAd? _rewardedAd;
  var rewardAmount=0;
  var rewardValue;
  var rewardAmountBox=GetStorage();

  var ourAdsPoint=0;
  bool isTrue=false;

  final auth=FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  AdmobHelper admobHelper = new AdmobHelper();
  @override
  Widget build(BuildContext context) {
    setState(() {
      ourAdsPoint=rewardAmountBox.read('rewardAmount')==null?0:rewardAmountBox.read('rewardAmount');
      Timer(Duration(hours: 24), () {
        rewardAmountBox.remove('rewardAmount');
      });
    });
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                FFLocalizations.of(context).getText(
                  '0eruqfxo' /* Accueil */,
                ),
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 22.0,
                    ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(112.0, 0.0, 0.0, 0.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'eo8vwvyx' /* se déconnecter */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
              FlutterFlowIconButton(
                borderColor: FlutterFlowTheme.of(context).primary,
                borderRadius: 20.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                fillColor: FlutterFlowTheme.of(context).accent1,
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 20.0,
                ),
                onPressed: () async {
                  GoRouter.of(context).prepareAuthEvent();
                  await authManager.signOut();
                  GoRouter.of(context).clearRedirectLocation();

                  context.goNamedAuth('Welcome', context.mounted);
                },
              ),
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1663782464052-d4f9a77b24a7?w=1280&h=720',
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height/4.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 0.0, 12.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'f7igs0tx' /* Bienvenue sur Seamstress */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'qwu6z6br' /* L'application qui vous aide à ... */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed('GPTFlow');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.chat_bubble_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'nsurpwgx' /* Poser vos questions */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 16.0,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.90, 0.00),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed('Notes');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.note,
                            color: Color(0xFFFF4AFF),
                            size: 24.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'e9cmh784' /* Vos Notes  */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 16.0,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.90, 0.00),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
              //   child: Container(
              //     width: double.infinity,
              //     height: 60.0,
              //     decoration: BoxDecoration(
              //       color: FlutterFlowTheme.of(context).secondaryBackground,
              //       borderRadius: BorderRadius.circular(12.0),
              //     ),
              //     child: Padding(
              //       padding:
              //           EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
              //       child: InkWell(
              //         splashColor: Colors.transparent,
              //         focusColor: Colors.transparent,
              //         hoverColor: Colors.transparent,
              //         highlightColor: Colors.transparent,
              //         onTap: () async {
              //           context.pushNamed('guidedUtilisationdeSeamstress');
              //         },
              //         child: Row(
              //           mainAxisSize: MainAxisSize.max,
              //           children: [
              //             Icon(
              //               Icons.library_books_rounded,
              //               color: FlutterFlowTheme.of(context).primaryText,
              //               size: 24.0,
              //             ),
              //             Padding(
              //               padding: EdgeInsetsDirectional.fromSTEB(
              //                   12.0, 0.0, 0.0, 0.0),
              //               child: Text(
              //                 FFLocalizations.of(context).getText(
              //                   'k8ntso5v' /* Guide d'utilisation de Seamstr... */,
              //                 ),
              //                 style: FlutterFlowTheme.of(context)
              //                     .labelMedium
              //                     .override(
              //                       fontFamily: 'Outfit',
              //                       fontSize: 16.0,
              //                     ),
              //               ),
              //             ),
              //             Expanded(
              //               child: Align(
              //                 alignment: AlignmentDirectional(0.90, 0.00),
              //                 child: Icon(
              //                   Icons.arrow_forward_ios,
              //                   color: FlutterFlowTheme.of(context).primaryText,
              //                   size: 18.0,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              //  Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
              //   child: Container(
              //     width: double.infinity,
              //     height: 60.0,
              //     decoration: BoxDecoration(
              //       color: FlutterFlowTheme.of(context).secondaryBackground,
              //       borderRadius: BorderRadius.circular(12.0),
              //     ),
              //     child: Padding(
              //       padding:
              //           EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
              //       child: InkWell(
              //         splashColor: Colors.transparent,
              //         focusColor: Colors.transparent,
              //         hoverColor: Colors.transparent,
              //         highlightColor: Colors.transparent,
              //       onTap: ourAdsPoint>=3?null:  ()  async {
              //           setState(() {
              //             isTrue=true;
              //           });
              //          await  RewardedAd.load(
              //               adUnitId: AdmobKey.rewardKey,
              //               rewardedAdLoadCallback: RewardedAdLoadCallback(
              //                 onAdLoaded: (RewardedAd ad) {
              //                   print('$ad loaded.');
              //                   // Keep a reference to the ad so you can show it later.
              //                   setState(() {
              //                     this._rewardedAd = ad;
              //                     _rewardedAd?.show(
              //                         onUserEarnedReward: (
              //                         AdWithoutView ad, RewardItem rewardItem) {
              //                       // Reward the user for watching an ad.
              //                       print('show reward : ${rewardItem.amount}');
              //                       setState(() {
              //                         isTrue=false;
              //                         // rewardAmount = '${rewardItem.amount}';
              //                         rewardAmount = rewardAmount+1;

              //                         rewardValue=rewardAmount==0?1-0:rewardAmount==2?2-1:3-2;
              //                         rewardAmountBox.write('rewardAmount', rewardAmount);
              //                         FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
              //                           'userPoint': FieldValue.increment(rewardValue),
              //                         });
              //                       });
              //                     });
              //                     _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
              //                       onAdShowedFullScreenContent: (RewardedAd ad) {
              //                         print('$ad onAdShowedFullScreenContent.');
              //                       },
              //                       onAdDismissedFullScreenContent: (RewardedAd ad) {
              //                         print('$ad onAdDismissedFullScreenContent.');
              //                         ad.dispose();
              //                       },
              //                       onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              //                         print('$ad onAdFailedToShowFullScreenContent: $error');
              //                         ad.dispose();
              //                       },
              //                       onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
              //                     );
              //                   });
              //                 },
              //                 onAdFailedToLoad: (LoadAdError error) {
              //                   print('RewardedAd failed to load: $error');
              //                 },
              //               ), request:  AdRequest());

              //           // admobHelper.createRewardAd();
              //           // context.pushNamed('guidedUtilisationdeSeamstress');
              //         },
              //         child: Row(
              //           mainAxisSize: MainAxisSize.max,
              //           children: [
              //             Icon(
              //               Icons.ads_click,
              //               color: FlutterFlowTheme.of(context).primaryText,
              //               size: 24.0,
              //             ),
              //             Padding(
              //               padding: EdgeInsetsDirectional.fromSTEB(
              //                   12.0, 0.0, 0.0, 0.0),
              //               child:ourAdsPoint>=3?  Text(
              //                 'Please wait for next day or parches points',
              //                 style: FlutterFlowTheme.of(context)
              //                     .labelMedium
              //                     .override(
              //                   fontFamily: 'Outfit',
              //                   fontSize: 12.0,
              //                 ),
              //               ):isTrue==true?Center(child: CircularProgressIndicator()): Text(
              //               'Watch Ad and Earn 3 Daily Credit',
              //                 style: FlutterFlowTheme.of(context)
              //                     .labelMedium
              //                     .override(
              //                       fontFamily: 'Outfit',
              //                       fontSize: 16.0,
              //                     ),
              //               ),
              //             ),
              //             Expanded(
              //               child: Align(
              //                 alignment: AlignmentDirectional(0.90, 0.00),
              //                 child: Icon(
              //                   Icons.arrow_forward_ios,
              //                   color: FlutterFlowTheme.of(context).primaryText,
              //                   size: 18.0,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
          
            ],
          ),
        ),
      ),
    );
  }
}
