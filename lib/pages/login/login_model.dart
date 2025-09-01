import '/components/signupcomponent_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'login_widget.dart' show LoginWidget;
import 'package:flutter/material.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  ///  Local state fields for this page.

  bool showEmailForum = true;

  ///  State fields for stateful widgets in this page.

  // Model for signupcomponent component.
  late SignupcomponentModel signupcomponentModel;

  @override
  void initState(BuildContext context) {
    signupcomponentModel = createModel(context, () => SignupcomponentModel());
  }

  @override
  void dispose() {
    signupcomponentModel.dispose();
  }
}
