import '/flutter_flow/flutter_flow_util.dart';
import 'base_input_field_widget.dart' show BaseInputFieldWidget;
import 'package:flutter/material.dart';

class BaseInputFieldModel extends FlutterFlowModel<BaseInputFieldWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  bool isDataUploading_uploadDataPath = false;
  FFUploadedFile uploadedLocalFile_uploadDataPath =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataPath = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
