import '/components/header_widget.dart';
import '/components/modals/search_modal/search_modal_widget.dart';
import '/components/sidebar/sidebar_widget.dart';
import '/components/sidebar_mobile/sidebar_mobile_widget.dart';
import '/components/store_items_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'store_widget.dart' show StoreWidget;
import 'package:flutter/material.dart';

class StoreModel extends FlutterFlowModel<StoreWidget> {
  ///  Local state fields for this page.

  bool item = false;

  bool? showSearchModal = false;

  bool showEmptyChat = true;

  bool showResponseLoading = false;

  ///  State fields for stateful widgets in this page.

  // Model for Sidebar component.
  late SidebarModel sidebarModel;
  // Model for header component.
  late HeaderModel headerModel;
  // Model for storeItems component.
  late StoreItemsModel storeItemsModel;
  // Model for SearchModal component.
  late SearchModalModel searchModalModel;
  // Model for sidebarMobile component.
  late SidebarMobileModel sidebarMobileModel;

  @override
  void initState(BuildContext context) {
    sidebarModel = createModel(context, () => SidebarModel());
    headerModel = createModel(context, () => HeaderModel());
    storeItemsModel = createModel(context, () => StoreItemsModel());
    searchModalModel = createModel(context, () => SearchModalModel());
    sidebarMobileModel = createModel(context, () => SidebarMobileModel());
  }

  @override
  void dispose() {
    sidebarModel.dispose();
    headerModel.dispose();
    storeItemsModel.dispose();
    searchModalModel.dispose();
    sidebarMobileModel.dispose();
  }
}
