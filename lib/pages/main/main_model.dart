import '/backend/api_requests/api_calls.dart';
import '/components/chat/empty_chat_state/empty_chat_state_widget.dart';
import '/components/header_widget.dart';
import '/components/modals/search_modal/search_modal_widget.dart';
import '/components/modals/skin_analysis_modal/skin_analysis_modal_widget.dart';
import '/components/modals/skincare_tips_modal/skincare_tips_modal_widget.dart';
import '/components/modals/product_recommendations_modal/product_recommendations_modal_widget.dart';
import '/components/modals/upload_photo_modal/upload_photo_modal_widget.dart';
import '/components/sidebar/sidebar_widget.dart';
import '/components/sidebar_mobile/sidebar_mobile_widget.dart';
import '/components/utils/attachments/attachments_widget.dart';
import '/components/utils/base_input_field/base_input_field_widget.dart';
import '/demo/demo_chat/demo_chat_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'main_widget.dart' show MainWidget;
import 'package:flutter/material.dart';

class MainModel extends FlutterFlowModel<MainWidget> {
  ///  Local state fields for this page.

  bool? showSearchModal = false;

  bool showAttachments = false;

  bool showEmptyChat = true;

  bool showResponseLoading = false;

  int chatAppendIndex = 0;

  bool showSkinAnalysisModal = false;

  bool showSkincareTipsModal = false;

  bool showProductRecommendationsModal = false;

  bool showUploadPhotoModal = false;

  ///  State fields for stateful widgets in this page.

  // Model for Sidebar component.
  late SidebarModel sidebarModel;
  // Model for header component.
  late HeaderModel headerModel;
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
  // Model for SkinAnalysisModal component.
  late SkinAnalysisModalModel skinAnalysisModalModel;
  // Model for SkincareTipsModal component.
  late SkincareTipsModalModel skincareTipsModalModel;
  // Model for ProductRecommendationsModal component.
  late ProductRecommendationsModalModel productRecommendationsModalModel;
  // Model for UploadPhotoModal component.
  late UploadPhotoModalModel uploadPhotoModalModel;
  // Model for sidebarMobile component.
  late SidebarMobileModel sidebarMobileModel;

  @override
  void initState(BuildContext context) {
    sidebarModel = createModel(context, () => SidebarModel());
    headerModel = createModel(context, () => HeaderModel());
    emptyChatStateModel = createModel(context, () => EmptyChatStateModel());
    demoChatModel = createModel(context, () => DemoChatModel());
    attachmentsModel = createModel(context, () => AttachmentsModel());
    baseInputFieldModel = createModel(context, () => BaseInputFieldModel());
    searchModalModel = createModel(context, () => SearchModalModel());
    skinAnalysisModalModel = createModel(context, () => SkinAnalysisModalModel());
    skincareTipsModalModel = createModel(context, () => SkincareTipsModalModel());
    productRecommendationsModalModel = createModel(context, () => ProductRecommendationsModalModel());
    uploadPhotoModalModel = createModel(context, () => UploadPhotoModalModel());
    sidebarMobileModel = createModel(context, () => SidebarMobileModel());
  }

  @override
  void dispose() {
    sidebarModel.dispose();
    headerModel.dispose();
    emptyChatStateModel.dispose();
    demoChatModel.dispose();
    attachmentsModel.dispose();
    baseInputFieldModel.dispose();
    searchModalModel.dispose();
    skinAnalysisModalModel.dispose();
    skincareTipsModalModel.dispose();
    productRecommendationsModalModel.dispose();
    uploadPhotoModalModel.dispose();
    sidebarMobileModel.dispose();
  }
}
