import '/components/header_widget.dart';
import '/components/modals/search_modal/search_modal_widget.dart';
import '/components/sidebar/sidebar_widget.dart';
import '/components/sidebar_mobile/sidebar_mobile_widget.dart';
import '/components/store_items_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'store_model.dart';
export 'store_model.dart';

class StoreWidget extends StatefulWidget {
  const StoreWidget({super.key});

  static String routeName = 'Store';
  static String routePath = '/store';

  @override
  State<StoreWidget> createState() => _StoreWidgetState();
}

class _StoreWidgetState extends State<StoreWidget>
    with TickerProviderStateMixin {
  late StoreModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StoreModel());

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

                context.pushNamed(
                  MainWidget.routeName,
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                    ),
                  },
                );
              },
              onSearch: () async {
                _model.showSearchModal = true;
                safeSetState(() {});
                Navigator.pop(context);
              },
              onItemSelect: () async {
                _model.showEmptyChat = false;
                _model.showResponseLoading = false;
                safeSetState(() {});
                Navigator.pop(context);
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
                            context.pushNamed(
                              MainWidget.routeName,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                ),
                              },
                            );
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
                    child: Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            wrapWithModel(
                              model: _model.headerModel,
                              updateCallback: () => safeSetState(() {}),
                              child: HeaderWidget(),
                            ),
                            wrapWithModel(
                              model: _model.storeItemsModel,
                              updateCallback: () => safeSetState(() {}),
                              child: StoreItemsWidget(),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
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
