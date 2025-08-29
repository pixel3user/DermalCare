import '/components/utils/chat_category/chat_category_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'sidebar_mobile_widget.dart' show SidebarMobileWidget;
import 'package:flutter/material.dart';

class SidebarMobileModel extends FlutterFlowModel<SidebarMobileWidget> {
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
