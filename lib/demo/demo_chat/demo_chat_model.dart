import '/flutter_flow/flutter_flow_util.dart';
import 'demo_chat_widget.dart' show DemoChatWidget;
import 'package:flutter/material.dart';

class DemoChatModel extends FlutterFlowModel<DemoChatWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for ScrollableWrapper widget.
  ScrollController? scrollableWrapper;

  @override
  void initState(BuildContext context) {
    scrollableWrapper = ScrollController();
  }

  @override
  void dispose() {
    scrollableWrapper?.dispose();
  }
}
