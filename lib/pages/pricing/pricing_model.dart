import '/components/footer_widget.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'pricing_widget.dart' show PricingWidget;
import 'package:flutter/material.dart';

class PricingModel extends FlutterFlowModel<PricingWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for footer component.
  late FooterModel footerModel;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    footerModel = createModel(context, () => FooterModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    footerModel.dispose();
    navbarModel.dispose();
  }
}
