import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'support_model.dart';
export 'support_model.dart';

class SupportWidget extends StatefulWidget {
  const SupportWidget({Key? key}) : super(key: key);

  @override
  _SupportWidgetState createState() => _SupportWidgetState();
}

class _SupportWidgetState extends State<SupportWidget> {
  late SupportModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SupportModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 30.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'veu6z03e' /* Support */,
            ),
            style: FlutterFlowTheme.of(context).titleMedium,
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200.0,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(
                              'https://images.unsplash.com/photo-1604881991720-f91add269bed?w=1280&h=720',
                            ).image,
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: AlignmentDirectional(-1.00, 1.00),
                      //   child: Padding(
                      //     padding: EdgeInsetsDirectional.fromSTEB(
                      //         24.0, 0.0, 0.0, 16.0),
                      //     child: Container(
                      //       width: 90.0,
                      //       height: 90.0,
                      //       decoration: BoxDecoration(
                      //         color: FlutterFlowTheme.of(context).accent1,
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //           color: FlutterFlowTheme.of(context).primary,
                      //           width: 2.0,
                      //         ),
                      //       ),
                      //       child: Padding(
                      //         padding: EdgeInsetsDirectional.fromSTEB(
                      //             4.0, 4.0, 4.0, 4.0),
                      //         child: ClipRRect(
                      //           borderRadius: BorderRadius.circular(50.0),
                      //           child: Image.network(
                      //             'https://images.unsplash.com/photo-1531094439740-f08f80c93e95?w=512&h=512',
                      //             width: 100.0,
                      //             height: 100.0,
                      //             fit: BoxFit.cover,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                //   child: Text(
                //     FFLocalizations.of(context).getText(
                //       'vekd7dxp' /* Support */,
                //     ),
                //     style: FlutterFlowTheme.of(context).headlineSmall,
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(24.0, 4.0, 0.0, 16.0),
                //   child: Text(
                //     FFLocalizations.of(context).getText(
                //       'cskwsjkq' /* Vous avez une question ou beso... */,
                //     ),
                //     style: FlutterFlowTheme.of(context).labelLarge,
                //   ),
                // ),
                // Padding(
                //   padding:
                //       EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                //   child: Container(
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: FlutterFlowTheme.of(context).secondaryBackground,
                //       borderRadius: BorderRadius.circular(12.0),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsetsDirectional.fromSTEB(
                //           12.0, 16.0, 12.0, 12.0),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.max,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             FFLocalizations.of(context).getText(
                //               'mb8q1ksg' /* Contact Information */,
                //             ),
                //             style: FlutterFlowTheme.of(context).labelMedium,
                //           ),
                //           Text(
                //             FFLocalizations.of(context).getText(
                //               'm4jcoc9y' /* Email: info@sacchic.ca */,
                //             ),
                //             style: FlutterFlowTheme.of(context).bodyLarge,
                //           ),
                //           Text(
                //             FFLocalizations.of(context).getText(
                //               'lczeropl' /* Phone: +1( 438 )-738-9182 */,
                //             ),
                //             style: FlutterFlowTheme.of(context).bodyLarge,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding:
                //       EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                //   child: Container(
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: FlutterFlowTheme.of(context).secondaryBackground,
                //       borderRadius: BorderRadius.circular(12.0),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsetsDirectional.fromSTEB(
                //           12.0, 16.0, 12.0, 12.0),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.max,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             FFLocalizations.of(context).getText(
                //               '8b5i7kcw' /* Vous  aimeriez savoir comment ... */,
                //             ),
                //             style: FlutterFlowTheme.of(context).bodyLarge,
                //           ),
                //           Padding(
                //             padding: EdgeInsetsDirectional.fromSTEB(
                //                 12.0, 0.0, 0.0, 0.0),
                //             child: FFButtonWidget(
                //               onPressed: () async {
                //                 context
                //                     .pushNamed('guidedUtilisationdeSeamstress');
                //               },
                //               text: FFLocalizations.of(context).getText(
                //                 '7pxolw7y' /* Voir le Guide */,
                //               ),
                //               options: FFButtonOptions(
                //                 width: double.infinity,
                //                 height: 44.0,
                //                 padding: EdgeInsetsDirectional.fromSTEB(
                //                     0.0, 0.0, 0.0, 0.0),
                //                 iconPadding: EdgeInsetsDirectional.fromSTEB(
                //                     0.0, 0.0, 0.0, 0.0),
                //                 color: FlutterFlowTheme.of(context).primary,
                //                 textStyle: FlutterFlowTheme.of(context)
                //                     .titleSmall
                //                     .override(
                //                       fontFamily: 'Plus Jakarta Sans',
                //                       color: Colors.white,
                //                     ),
                //                 elevation: 3.0,
                //                 borderRadius: BorderRadius.circular(12.0),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding:
                //       EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                //   child: Container(
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: FlutterFlowTheme.of(context).secondaryBackground,
                //       borderRadius: BorderRadius.circular(12.0),
                //     ),
                //   ),
                // ),
          
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
