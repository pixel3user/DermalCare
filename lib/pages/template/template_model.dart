import '/components/chat/chat/chat_widget.dart';
import '/components/chat/empty_chat_state/empty_chat_state_widget.dart';
import '/components/modals/search_modal/search_modal_widget.dart';
import '/components/sidebar/sidebar_widget.dart';
import '/components/utils/attachments/attachments_widget.dart';
import '/components/utils/base_input_field/base_input_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'template_widget.dart' show TemplateWidget;
import 'package:flutter/material.dart';

class TemplateModel extends FlutterFlowModel<TemplateWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Sidebar component.
  late SidebarModel sidebarModel;
  // Model for EmptyChatState component.
  late EmptyChatStateModel emptyChatStateModel;
  // Model for Chat component.
  late ChatModel chatModel;
  // Model for Attachments component.
  late AttachmentsModel attachmentsModel;
  // Model for BaseInputField component.
  late BaseInputFieldModel baseInputFieldModel;
  // Model for SearchModal component.
  late SearchModalModel searchModalModel;

  @override
  void initState(BuildContext context) {
    sidebarModel = createModel(context, () => SidebarModel());
    emptyChatStateModel = createModel(context, () => EmptyChatStateModel());
    chatModel = createModel(context, () => ChatModel());
    attachmentsModel = createModel(context, () => AttachmentsModel());
    baseInputFieldModel = createModel(context, () => BaseInputFieldModel());
    searchModalModel = createModel(context, () => SearchModalModel());
  }

  @override
  void dispose() {
    sidebarModel.dispose();
    emptyChatStateModel.dispose();
    chatModel.dispose();
    attachmentsModel.dispose();
    baseInputFieldModel.dispose();
    searchModalModel.dispose();
  }
}
