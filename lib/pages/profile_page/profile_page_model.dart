import '/components/header_widget.dart';
import '/components/modals/search_modal/search_modal_widget.dart';
import '/components/profile_widget.dart';
import '/components/sidebar/sidebar_widget.dart';
import '/components/sidebar_mobile/sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  Local state fields for this page.

  bool? showSearchModal = false;

  bool showAttachments = false;

  bool showEmptyChat = true;

  bool showResponseLoading = false;

  ///  State fields for stateful widgets in this page.

  // Model for Sidebar component.
  late SidebarModel sidebarModel;
  // Model for header component.
  late HeaderModel headerModel;
  // Model for profile component.
  late ProfileModel profileModel;
  // Model for SearchModal component.
  late SearchModalModel searchModalModel;
  // Model for sidebarMobile component.
  late SidebarMobileModel sidebarMobileModel;

  @override
  void initState(BuildContext context) {
    sidebarModel = createModel(context, () => SidebarModel());
    headerModel = createModel(context, () => HeaderModel());
    profileModel = createModel(context, () => ProfileModel());
    searchModalModel = createModel(context, () => SearchModalModel());
    sidebarMobileModel = createModel(context, () => SidebarMobileModel());
  }

  @override
  void dispose() {
    sidebarModel.dispose();
    headerModel.dispose();
    profileModel.dispose();
    searchModalModel.dispose();
    sidebarMobileModel.dispose();
  }
}
