import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'demo_chat_model.dart';
export 'demo_chat_model.dart';

class DemoChatWidget extends StatefulWidget {
  const DemoChatWidget({
    super.key,
    bool? isFetchingResponse,
  }) : this.isFetchingResponse = isFetchingResponse ?? false;

  final bool isFetchingResponse;

  @override
  State<DemoChatWidget> createState() => _DemoChatWidgetState();
}

class _DemoChatWidgetState extends State<DemoChatWidget> {
  late DemoChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DemoChatModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _model.scrollableWrapper?.animateTo(
        _model.scrollableWrapper!.position.maxScrollExtent,
        duration: Duration(milliseconds: 100),
        curve: Curves.ease,
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      constraints: BoxConstraints(
        maxWidth: 752.0,
      ),
      decoration: BoxDecoration(),
      child: SingleChildScrollView(
        controller: _model.scrollableWrapper,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: Builder(
                builder: (context) {
                  final chatHistory = FFAppState().chatHistory.toList();

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(chatHistory.length,
                        (chatHistoryIndex) {
                      final chatHistoryItem =
                          chatHistory[chatHistoryIndex] as Map;
                      final userMessage =
                          chatHistoryItem.keys.first.toString();
                      final botMessage =
                          chatHistoryItem.values.first;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(1.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 8.0, 12.0, 8.0),
                              child: Text(
                                userMessage,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.interTight(),
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 8.0, 12.0, 8.0),
                              child: Text(
                                botMessage?.toString() ?? '',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.interTight(),
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(height: 8.0)),
                      );
                    })
                        .divide(SizedBox(height: 24.0))
                        .addToStart(SizedBox(height: 12.0))
                        .addToEnd(SizedBox(height: 24.0)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
