import '/components/utils/chat_category/chat_category_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'sidebar_widget.dart' show SidebarWidget;
import 'package:flutter/material.dart';

class SidebarModel extends FlutterFlowModel<SidebarWidget> {
  ///  Local state fields for this component.

  bool isExtended = true;

  ///  State fields for stateful widgets in this component.

  // Model for ChatCategory component.
  late ChatCategoryModel chatCategoryModel;

  @override
  void initState(BuildContext context) {
    chatCategoryModel = createModel(context, () => ChatCategoryModel());
  }

  @override
  void dispose() {
    chatCategoryModel.dispose();
  }
}
