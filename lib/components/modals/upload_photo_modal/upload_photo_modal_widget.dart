import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'upload_photo_modal_model.dart';
export 'upload_photo_modal_model.dart';

class UploadPhotoModalWidget extends StatefulWidget {
  const UploadPhotoModalWidget({
    super.key,
    this.onClose,
    this.onPhotoUploaded,
  });

  final Future Function()? onClose;
  final Future Function(String)? onPhotoUploaded;

  @override
  State<UploadPhotoModalWidget> createState() => _UploadPhotoModalWidgetState();
}

class _UploadPhotoModalWidgetState extends State<UploadPhotoModalWidget> {
  late UploadPhotoModalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UploadPhotoModalModel());
    _model.initState(context);
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await widget.onClose?.call();
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).accent4.withOpacity(0.8),
        ),
        alignment: AlignmentDirectional(0.0, 0.0),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            // Prevent closing when tapping the modal content
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width < kBreakpointSmall
                ? (MediaQuery.sizeOf(context).width * 0.95)
                : 500.0,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.85,
              minHeight: 400.0,
            ),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20.0,
                  color: Color(0x33000000),
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 16.0),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upload Photo',
                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                              font: GoogleFonts.interTight(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight:
                                  FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                              fontStyle:
                                  FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                            ),
                      ),
                      FlutterFlowIconButton(
                        borderRadius: 20.0,
                        buttonSize: 40.0,
                        fillColor: FlutterFlowTheme.of(context).accent4,
                        icon: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 20.0,
                        ),
                        onPressed: () async {
                          await widget.onClose?.call();
                        },
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                    child: Column(
                      children: [
                        Text(
                          'Upload a photo for analysis',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).bodyLarge.override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                              ),
                        ),
                        SizedBox(height: 24.0),
                        // Upload options
                        Row(
                          children: [
                            Expanded(
                              child: _buildUploadOption(
                                'Camera',
                                Icons.camera_alt,
                                () => _model.pickImage(ImageSource.camera),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              child: _buildUploadOption(
                                'Gallery',
                                Icons.photo_library,
                                () => _model.pickImage(ImageSource.gallery),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        // Selected image preview
                        if (_model.selectedImage != null)
                          Container(
                            height: 200.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).accent4,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14.0),
                              child: Image.file(
                                File(_model.selectedImage!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        SizedBox(height: 24.0),
                        // Upload button
                        FFButtonWidget(
                          onPressed: () async {
                            if (_model.selectedImage != null) {
                              // Simulate upload
                              _model.uploadedImageUrl = _model.selectedImage!.path;
                              await widget.onPhotoUploaded?.call(_model.uploadedImageUrl!);
                            }
                          },
                          text: 'Upload & Analyze',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 48.0,
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                            disabledColor: FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadOption(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 80.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).accent4,
            width: 1.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: FlutterFlowTheme.of(context).primary,
              size: 32.0,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.interTight(
                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

enum UploadStep {
  selection,
  preview,
  uploading,
}