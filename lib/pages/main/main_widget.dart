import '/components/chat/empty_chat_state/empty_chat_state_widget.dart';
import '/components/modals/search_modal/search_modal_widget.dart';
import '/components/sidebar/sidebar_widget.dart';
import '/components/utils/attachments/attachments_widget.dart';
import '/components/utils/base_input_field/base_input_field_widget.dart';
import '/demo/demo_chat/demo_chat_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_model.dart';
export 'main_model.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  static String routeName = 'Main';
  static String routePath = '/main';

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  late MainModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  wrapWithModel(
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
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 24.0, 24.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                text: 'Share',
                                icon: Icon(
                                  Icons.share,
                                  size: 16.0,
                                ),
                                options: FFButtonOptions(
                                  height: 36.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.interTight(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).accent4,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                              Container(
                                width: 36.0,
                                height: 36.0,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'assets/images/Ellipse_1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (_model.showEmptyChat) {
                                return Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Container(
                                    child: wrapWithModel(
                                      model: _model.emptyChatStateModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: EmptyChatStateWidget(
                                        onItemPress: () async {
                                          _model.showEmptyChat = false;
                                          safeSetState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return wrapWithModel(
                                  model: _model.demoChatModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: DemoChatWidget(
                                    isFetchingResponse:
                                        _model.showResponseLoading,
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
                                    wrapWithModel(
                                      model: _model.attachmentsModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: AttachmentsWidget(
                                        onFileDelete: () async {
                                          _model.showAttachments = false;
                                          safeSetState(() {});
                                        },
                                      ),
                                    ),
                                  wrapWithModel(
                                    model: _model.baseInputFieldModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: BaseInputFieldWidget(
                                      onNewMessage: () async {
                                        _model.showEmptyChat = false;
                                        _model.showResponseLoading = true;
                                        safeSetState(() {});
                                        safeSetState(() {
                                          _model.baseInputFieldModel
                                              .textController
                                              ?.clear();
                                        });
                                        await Future.delayed(
                                          Duration(
                                            milliseconds: 5000,
                                          ),
                                        );
                                        _model.showResponseLoading = false;
                                        safeSetState(() {});
                                      },
                                      onNewFileAttached: () async {
                                        _model.showAttachments = true;
                                        safeSetState(() {});
                                      },
                                    ),
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
