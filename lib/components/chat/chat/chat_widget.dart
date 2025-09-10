import '/components/chat/chat_request/chat_request_widget.dart';
import '/components/chat/chat_response_a_i/chat_response_a_i_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'chat_model.dart';
export 'chat_model.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    super.key,
    this.chatHistory,
  });

  final List<Map<String, String?>>? chatHistory;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late ChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());

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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildChatMessages()
                    .divide(SizedBox(height: 24.0))
                    .addToStart(SizedBox(height: 12.0))
                    .addToEnd(SizedBox(height: 24.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChatMessages() {
    if (widget.chatHistory == null || widget.chatHistory!.isEmpty) {
      // Default demo messages
      return [
        wrapWithModel(
          model: _model.chatRequestModel,
          updateCallback: () => safeSetState(() {}),
          child: ChatRequestWidget(
            text: 'Hello, how are you? This is my dog :)\nCan you put the crown on its head please?',
            mediaPath: 'https://s3-alpha-sig.figma.com/img/8edc/82de/970652999e82613f3c3525d1db5fb12e?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=ZRj5dT~6d7fDMVwj3YUz-pSV4HXvCFKdDKg2YFXBx-Lvkc7tSbdyrr-AD544XC9ZhBsUKWRLXdkjPgQbXhJ-X7m~RvzTBoGt0d~n2Yf1WWfKe2p1dnGEMFpGfQFpc509M14xzsAWE2gOqevBrwirDkMA4S3Xkul0zobeqJQioE8hpZfJu-N6AEzPhs~zKruKlKQc9Vxo4mqqxEQ3aoqX-UMo~AM7yNpICK0N1MURBZOA22LXwNBWsLLwzzb~4S0CgosDHwy~XX~jM-f0JaKQ4S4MumfUjIqo8-9PvKBb3A6QQHiJ8k8n8fl9MabqUvJF71xP8ihoRjjqjkHevtgzOA__',
          ),
        ),
        wrapWithModel(
          model: _model.chatResponseAIModel,
          updateCallback: () => safeSetState(() {}),
          child: ChatResponseAIWidget(
            content: 'I\'m doing great! Thanks for sharing your dog\'s picture! I\'ll edit the image now and add a crown to your dog\'s head. Give me a moment...',
            isResponding: true,
          ),
        ),
      ];
    }

    List<Widget> messages = [];
    for (var message in widget.chatHistory!) {
      // Add user message
      if (message['query'] != null && message['query']!.isNotEmpty) {
        messages.add(
          wrapWithModel(
            model: _model.chatRequestModel,
            updateCallback: () => safeSetState(() {}),
            child: ChatRequestWidget(
              text: message['query'],
              mediaPath: message['mediaPath'],
            ),
          ),
        );
      }

      // Add AI response
      if (message['response'] != null && message['response']!.isNotEmpty) {
        messages.add(
          wrapWithModel(
            model: _model.chatResponseAIModel,
            updateCallback: () => safeSetState(() {}),
            child: ChatResponseAIWidget(
              content: message['response'],
              isResponding: false,
            ),
          ),
        );
      }
    }

    return messages;
  }
}
