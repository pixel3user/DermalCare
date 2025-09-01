import '/components/item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'store_items_widget.dart' show StoreItemsWidget;
import 'package:flutter/material.dart';

class StoreItemsModel extends FlutterFlowModel<StoreItemsWidget> {
  ///  Local state fields for this component.

  bool item = true;

  ///  State fields for stateful widgets in this component.

  // Model for Item component.
  late ItemModel itemModel;

  @override
  void initState(BuildContext context) {
    itemModel = createModel(context, () => ItemModel());
  }

  @override
  void dispose() {
    itemModel.dispose();
  }
}
