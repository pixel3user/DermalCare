import '/components/modals/upload_photo_modal/upload_photo_modal_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoModalModel extends FlutterFlowModel<UploadPhotoModalWidget> {
  UploadStep currentStep = UploadStep.selection;
  XFile? selectedImage;
  String? uploadedImageUrl;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  void setStep(UploadStep step) {
    currentStep = step;
    onUpdate();
  }

  void onUpdate() {
    // This method is called when the model needs to notify listeners
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      
      if (image != null) {
        selectedImage = image;
        setStep(UploadStep.preview);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void showDragDropArea() {
    // This would typically show a drag and drop area
    // For now, we'll just show a message
    print('Drag and drop functionality would be implemented here');
  }

  Future<void> uploadPhoto() async {
    if (selectedImage == null) return;

    try {
      // Simulate upload process
      await Future.delayed(Duration(seconds: 2));
      
      // In a real implementation, you would upload to your server/cloud storage
      // For now, we'll just use the local path
      uploadedImageUrl = selectedImage!.path;
      
      print('Photo uploaded: $uploadedImageUrl');
    } catch (e) {
      print('Error uploading photo: $e');
    }
  }
}
