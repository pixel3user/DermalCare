import '/backend/api_requests/api_calls.dart';
import '/components/chat/empty_chat_state/empty_chat_state_widget.dart';
import '/components/modals/search_modal/search_modal_widget.dart';
import '/components/sidebar/sidebar_widget.dart';
import '/components/sidebar_mobile/sidebar_mobile_widget.dart';
import '/components/utils/attachments/attachments_widget.dart';
import '/components/utils/base_input_field/base_input_field_widget.dart';
import '/demo/demo_chat/demo_chat_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'main_widget.dart' show MainWidget;
import 'package:flutter/material.dart';

class MainModel extends FlutterFlowModel<MainWidget> {
  ///  Local state fields for this page.

  bool? showSearchModal = false;

  bool showAttachments = false;

  bool showEmptyChat = true;

  bool showResponseLoading = false;

  ///  State fields for stateful widgets in this page.

  // Model for Sidebar component.
  late SidebarModel sidebarModel;
  // Model for EmptyChatState component.
  late EmptyChatStateModel emptyChatStateModel;
  // Model for DemoChat component.
  late DemoChatModel demoChatModel;
  // Model for Attachments component.
  late AttachmentsModel attachmentsModel;
  // Model for BaseInputField component.
  late BaseInputFieldModel baseInputFieldModel;
  // Stores action output result for [Backend Call - API (dermacareCall)] action in BaseInputField widget.
  ApiCallResponse? apiResult;
  // Model for SearchModal component.
  late SearchModalModel searchModalModel;
  // Model for sidebarMobile component.
  late SidebarMobileModel sidebarMobileModel;

  @override
  void initState(BuildContext context) {
    sidebarModel = createModel(context, () => SidebarModel());
    emptyChatStateModel = createModel(context, () => EmptyChatStateModel());
    demoChatModel = createModel(context, () => DemoChatModel());
    attachmentsModel = createModel(context, () => AttachmentsModel());
    baseInputFieldModel = createModel(context, () => BaseInputFieldModel());
    searchModalModel = createModel(context, () => SearchModalModel());
    sidebarMobileModel = createModel(context, () => SidebarMobileModel());
  }

  @override
  void dispose() {
    sidebarModel.dispose();
    emptyChatStateModel.dispose();
    demoChatModel.dispose();
    attachmentsModel.dispose();
    baseInputFieldModel.dispose();
    searchModalModel.dispose();
    sidebarMobileModel.dispose();
  }
}
