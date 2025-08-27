import '/components/chat/chat_response_feedback/chat_response_feedback_widget.dart';
import '/components/skeletons/image_skeleton/image_skeleton_widget.dart';
import '/components/skeletons/text_skeleton/text_skeleton_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat_response_a_i_model.dart';
export 'chat_response_a_i_model.dart';

class ChatResponseAIWidget extends StatefulWidget {
  const ChatResponseAIWidget({
    super.key,
    String? content,
    bool? isResponding,
  })  : this.content = content ?? 'This is AI response.',
        this.isResponding = isResponding ?? false;

  final String content;
  final bool isResponding;

  @override
  State<ChatResponseAIWidget> createState() => _ChatResponseAIWidgetState();
}

class _ChatResponseAIWidgetState extends State<ChatResponseAIWidget> {
  late ChatResponseAIModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatResponseAIModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(-1.0, 0.0),
      child: Container(
        decoration: BoxDecoration(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Image.asset(
                'assets/images/AI_Icon.png',
                width: 32.0,
                height: 32.0,
                fit: BoxFit.cover,
              ),
            ),
            Builder(
              builder: (context) {
                if (widget.isResponding) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      wrapWithModel(
                        model: _model.textSkeletonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TextSkeletonWidget(
                          text: 'Thinking...',
                        ),
                      ),
                      wrapWithModel(
                        model: _model.imageSkeletonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: ImageSkeletonWidget(),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width <
                                  kBreakpointSmall
                              ? (MediaQuery.sizeOf(context).width * 0.7)
                              : 540.0,
                        ),
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 4.0, 0.0, 0.0),
                          child: SelectionArea(
                              child: Text(
                            widget.content,
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                      lineHeight: 1.5,
                                    ),
                          )),
                        ),
                      ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 300.0,
                          ),
                          decoration: BoxDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      wrapWithModel(
                        model: _model.chatResponseFeedbackModel,
                        updateCallback: () => safeSetState(() {}),
                        child: ChatResponseFeedbackWidget(),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  );
                }
              },
            ),
          ].divide(SizedBox(width: 16.0)),
        ),
      ),
    );
  }
}
