import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/chat/empty_chat_state/empty_chat_state_widget.dart';
import '/components/header_widget.dart';
import '/components/modals/search_modal/search_modal_widget.dart';
import '/components/sidebar/sidebar_widget.dart';
import '/components/sidebar_mobile/sidebar_mobile_widget.dart';
import '/components/utils/attachments/attachments_widget.dart';
import '/components/utils/base_input_field/base_input_field_widget.dart';
import '/demo/demo_chat/demo_chat_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'main_model.dart';
export 'main_model.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  static String routeName = 'Main';
  static String routePath = '/main';

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  late MainModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainModel());

    animationsMap.addAll({
      'sidebarOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(-100.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'emptyChatStateOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.2,
            end: 1.0,
          ),
        ],
      ),
      'baseInputFieldOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 100.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Drawer(
          elevation: 16.0,
          child: wrapWithModel(
            model: _model.sidebarMobileModel,
            updateCallback: () => safeSetState(() {}),
            child: SidebarMobileWidget(
              onNewChat: () async {
                Navigator.pop(context);
                _model.showEmptyChat = true;
                safeSetState(() {});
              },
              onSearch: () async {
                _model.showSearchModal = true;
                safeSetState(() {});
                Navigator.pop(context);
              },
              onItemSelect: () async {
                Navigator.pop(context);
                _model.showEmptyChat = false;
                _model.showResponseLoading = false;
                safeSetState(() {});
              },
            ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                  ))
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: wrapWithModel(
                        model: _model.sidebarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: SidebarWidget(
                          onNewChat: () async {
                            _model.showEmptyChat = true;
                            safeSetState(() {});
                          },
                          onItemSelect: () async {
                            _model.showEmptyChat = false;
                            _model.showResponseLoading = false;
                            safeSetState(() {});
                          },
                          onSearch: () async {
                            _model.showSearchModal = true;
                            safeSetState(() {});
                          },
                        ),
                      ).animateOnPageLoad(
                          animationsMap['sidebarOnPageLoadAnimation']!),
                    ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        wrapWithModel(
                          model: _model.headerModel,
                          updateCallback: () => safeSetState(() {}),
                          child: HeaderWidget(),
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (_model.showEmptyChat) {
                                return Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 5.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.emptyChatStateModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: EmptyChatStateWidget(
                                          onItemPress: () async {
                                            _model.showEmptyChat = false;
                                            safeSetState(() {});
                                          },
                                        ),
                                      ).animateOnPageLoad(animationsMap[
                                          'emptyChatStateOnPageLoadAnimation']!),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 5.0, 0.0),
                                  child: wrapWithModel(
                                    model: _model.demoChatModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: DemoChatWidget(
                                      isFetchingResponse:
                                          _model.showResponseLoading,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (_model.showAttachments)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 5.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.attachmentsModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AttachmentsWidget(
                                          onFileDelete: () async {
                                            _model.showAttachments = false;
                                            safeSetState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 5.0, 0.0),
                                    child: wrapWithModel(
                                      model: _model.baseInputFieldModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: BaseInputFieldWidget(
                                        onNewMessage: () async {
                                          _model.showEmptyChat = false;
                                          _model.showResponseLoading = true;
                                          safeSetState(() {});
                                          FFAppState().chatboxText = _model
                                              .baseInputFieldModel
                                              .textController
                                              .text;
                                          FFAppState().addToChatHistory(<String,
                                              dynamic>{
                                            _model
                                                .baseInputFieldModel
                                                .textController
                                                .text: <String, dynamic>{},
                                          });
                                          safeSetState(() {});
                                          safeSetState(() {
                                            _model.baseInputFieldModel
                                                .textController
                                                ?.clear();
                                          });
                                          _model.apiResult =
                                              await DermacareCallCall.call(
                                            apiText: FFAppState().chatboxText,
                                            apiMedia: _model.baseInputFieldModel
                                                            .uploadedFileUrl_uploadDataPath !=
                                                        ''
                                                ? _model.baseInputFieldModel
                                                    .uploadedFileUrl_uploadDataPath
                                                : '',
                                            authToken: currentJwtToken,
                                          );

                                          if ((_model.apiResult?.succeeded ??
                                              true)) {
                                            FFAppState().chatboxResponse =
                                                getJsonField(
                                              (_model.apiResult?.jsonBody ??
                                                  ''),
                                              r'''$.answer''',
                                            ).toString();
                                            FFAppState()
                                                .updateChatHistoryAtIndex(
                                              FFAppState()
                                                      .chatHistory.length -
                                                  1,
                                              (_) => <String, dynamic>{
                                                FFAppState()
                                                    .chatboxText:
                                                    FFAppState()
                                                        .chatboxResponse,
                                              },
                                            );
                                            safeSetState(() {});
                                          } else {
                                            FFAppState().chatboxResponse =
                                                'An Error has occured.';
                                            safeSetState(() {});
                                          }

                                          _model.showResponseLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        onNewFileAttached: () async {
                                          _model.showAttachments = true;
                                          safeSetState(() {});
                                        },
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'baseInputFieldOnPageLoadAnimation']!),
                                  ),
                                ].divide(SizedBox(height: 8.0)),
                              ),
                              Text(
                                'Dermacare can make mistakes. Check important info.',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: Color(0x80FFFFFF),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                  ),
                ],
              ),
              if (_model.showSearchModal ?? true)
                wrapWithModel(
                  model: _model.searchModalModel,
                  updateCallback: () => safeSetState(() {}),
                  child: SearchModalWidget(
                    onClose: () async {
                      _model.showSearchModal = false;
                      safeSetState(() {});
                    },
                    onItemSelect: () async {
                      _model.showEmptyChat = false;
                      _model.showResponseLoading = false;
                      safeSetState(() {});
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
