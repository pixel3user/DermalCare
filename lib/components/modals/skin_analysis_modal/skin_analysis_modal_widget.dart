import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'skin_analysis_modal_model.dart';
export 'skin_analysis_modal_model.dart';

class SkinAnalysisModalWidget extends StatefulWidget {
  const SkinAnalysisModalWidget({
    super.key,
    this.onClose,
  });

  final Future Function()? onClose;

  @override
  State<SkinAnalysisModalWidget> createState() => _SkinAnalysisModalWidgetState();
}

class _SkinAnalysisModalWidgetState extends State<SkinAnalysisModalWidget> {
  late SkinAnalysisModalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SkinAnalysisModalModel());
    _model.initState(context);
    // Initialize camera after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _model.initializeCamera();
    });
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
                        'Skin Analysis',
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
                    child: _buildContent(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_model.currentStep == SkinAnalysisStep.bodyPartSelection) {
      return _buildBodyPartSelection();
    } else if (_model.currentStep == SkinAnalysisStep.cameraCapture) {
      return _buildCameraCapture();
    } else if (_model.currentStep == SkinAnalysisStep.analysis) {
      return _buildAnalysis();
    }
    return SizedBox.shrink();
  }

  Widget _buildBodyPartSelection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Select the area you want to analyze',
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
        SizedBox(height: 32.0),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.9,
          children: [
            _buildBodyPartCard(
              'Face',
              Icons.face,
              'Analyze facial skin concerns',
              () => _model.selectBodyPart('face'),
            ),
            _buildBodyPartCard(
              'Hands',
              Icons.back_hand,
              'Check hand skin condition',
              () => _model.selectBodyPart('hands'),
            ),
            _buildBodyPartCard(
              'Body',
              Icons.accessibility_new,
              'Analyze body skin concerns',
              () => _model.selectBodyPart('body'),
            ),
            _buildBodyPartCard(
              'Scalp',
              Icons.content_cut,
              'Examine scalp health',
              () => _model.selectBodyPart('scalp'),
            ),
          ],
        ),
        SizedBox(height: 24.0),
        FFButtonWidget(
          onPressed: () async {
            if (_model.selectedBodyPart != null) {
              _model.setStep(SkinAnalysisStep.cameraCapture);
            }
          },
          text: 'Continue',
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
    );
  }

  Widget _buildBodyPartCard(String title, IconData icon, String description, VoidCallback onTap) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: _model.selectedBodyPart == title.toLowerCase()
              ? FlutterFlowTheme.of(context).primary.withOpacity(0.1)
              : FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: _model.selectedBodyPart == title.toLowerCase()
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).accent4,
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: _model.selectedBodyPart == title.toLowerCase()
                    ? FlutterFlowTheme.of(context).primary
                    : FlutterFlowTheme.of(context).secondaryText,
                size: 28.0,
              ),
              SizedBox(height: 6.0),
              Text(
                title,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.interTight(
                        fontWeight: FontWeight.w600,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
              SizedBox(height: 4.0),
              Expanded(
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.interTight(
                          fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontSize: 11.0,
                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraCapture() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Capture ${_model.selectedBodyPart} for analysis',
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
        Container(
          height: 300.0,
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
            child: _model.cameraController != null && _model.cameraController!.value.isInitialized
                ? CameraPreview(_model.cameraController!)
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 48.0,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          _model.cameraController == null 
                              ? 'Initializing camera...' 
                              : 'Camera not available',
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
          ),
        ),
        SizedBox(height: 24.0),
        Row(
          children: [
            Expanded(
              child: FFButtonWidget(
                onPressed: () async {
                  _model.setStep(SkinAnalysisStep.bodyPartSelection);
                },
                text: 'Back',
                options: FFButtonOptions(
                  height: 48.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).secondaryBackground,
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
                    color: FlutterFlowTheme.of(context).accent4,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: FFButtonWidget(
                onPressed: () async {
                  await _model.capturePhoto();
                  _model.setStep(SkinAnalysisStep.analysis);
                },
                text: 'Capture',
                options: FFButtonOptions(
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
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnalysis() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.analytics,
            color: FlutterFlowTheme.of(context).primary,
            size: 40.0,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'Analyzing your skin...',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
                font: GoogleFonts.interTight(
                  fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
              ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Our AI is examining your ${_model.selectedBodyPart} for any concerns',
          textAlign: TextAlign.center,
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
        SizedBox(height: 24.0),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            FlutterFlowTheme.of(context).primary,
          ),
        ),
      ],
    );
  }
}

enum SkinAnalysisStep {
  bodyPartSelection,
  cameraCapture,
  analysis,
}