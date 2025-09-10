import '/components/chat/chat_bubble/chat_bubble_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'chat_request_model.dart';
export 'chat_request_model.dart';

class ChatRequestWidget extends StatefulWidget {
  const ChatRequestWidget({
    super.key,
    this.text,
    this.mediaPath,
  });

  final String? text;
  final String? mediaPath;

  @override
  State<ChatRequestWidget> createState() => _ChatRequestWidgetState();
}

class _ChatRequestWidgetState extends State<ChatRequestWidget> {
  late ChatRequestModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatRequestModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        wrapWithModel(
          model: _model.chatBubbleModel,
          updateCallback: () => safeSetState(() {}),
          child: ChatBubbleWidget(
            text: widget.text,
          ),
        ),
        if (widget.mediaPath != null && widget.mediaPath!.isNotEmpty)
          Align(
            alignment: AlignmentDirectional(1.0, 0.0),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 220.0,
              ),
              decoration: BoxDecoration(),
              child: Align(
                alignment: AlignmentDirectional(1.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.mediaPath!,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 200.0,
                        height: 200.0,
                        color: FlutterFlowTheme.of(context).accent4,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2.0,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 200.0,
                      height: 200.0,
                      color: FlutterFlowTheme.of(context).accent4,
                      child: Icon(
                        Icons.broken_image,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 48.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ].divide(SizedBox(height: 8.0)),
    );
  }
}
