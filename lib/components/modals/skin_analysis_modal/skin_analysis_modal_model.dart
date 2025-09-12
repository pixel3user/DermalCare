import '/components/modals/skin_analysis_modal/skin_analysis_modal_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class SkinAnalysisModalModel extends FlutterFlowModel<SkinAnalysisModalWidget> {
  ///  Local state fields for this component.

  SkinAnalysisStep currentStep = SkinAnalysisStep.bodyPartSelection;
  String? selectedBodyPart;
  CameraController? cameraController;
  XFile? capturedImage;

  @override
  void initState(BuildContext context) {
    // Don't initialize camera here, it will be done after widget is built
  }

  @override
  void dispose() {
    cameraController?.dispose();
  }

  void onUpdate() {
    // This method is called when the model needs to notify listeners
  }

  void setStep(SkinAnalysisStep step) {
    currentStep = step;
    onUpdate();
  }

  void selectBodyPart(String bodyPart) {
    selectedBodyPart = bodyPart;
    onUpdate();
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(
          cameras.first,
          ResolutionPreset.high,
          enableAudio: false,
        );
        await cameraController!.initialize();
        onUpdate();
      } else {
        print('No cameras available');
      }
    } catch (e) {
      print('Error initializing camera: $e');
      // Handle camera initialization error gracefully
      cameraController = null;
      onUpdate();
    }
  }

  Future<void> capturePhoto() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      try {
        capturedImage = await cameraController!.takePicture();
        onUpdate();
      } catch (e) {
        print('Error capturing photo: $e');
      }
    } else {
      print('Camera not initialized or available');
    }
  }
}