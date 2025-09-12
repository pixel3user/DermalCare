import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'base_input_field_model.dart';
export 'base_input_field_model.dart';

class BaseInputFieldWidget extends StatefulWidget {
  const BaseInputFieldWidget({
    super.key,
    this.onNewMessage,
    this.onNewFileAttached,
  });

  final Future Function()? onNewMessage;
  final Future Function()? onNewFileAttached;

  @override
  State<BaseInputFieldWidget> createState() => _BaseInputFieldWidgetState();
}

class _BaseInputFieldWidgetState extends State<BaseInputFieldWidget> {
  late BaseInputFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BaseInputFieldModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 720.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              child: TextFormField(
                controller: _model.textController,
                focusNode: _model.textFieldFocusNode,
                autofocus: false,
                obscureText: false,
                decoration: InputDecoration(
                  isDense: true,
                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.interTight(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                  hintText: 'Ask about your skin concerns...',
                  hintStyle: FlutterFlowTheme.of(context).labelLarge.override(
                        font: GoogleFonts.interTight(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelLarge.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).labelLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelLarge.fontStyle,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.interTight(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                    ),
                maxLines: 3,
                minLines: 1,
                cursorColor: FlutterFlowTheme.of(context).primaryText,
                validator: _model.textControllerValidator.asValidator(context),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        final selectedMedia =
                            await selectMediaWithSourceBottomSheet(
                          context: context,
                          maxWidth: 800.00,
                          maxHeight: 800.00,
                          imageQuality: 50,
                          allowPhoto: true,
                          allowVideo: true,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          safeSetState(() =>
                              _model.isDataUploading_uploadDataPath = true);
                          var selectedUploadedFiles = <FFUploadedFile>[];

                          var downloadUrls = <String>[];
                          try {
                            showUploadMessage(
                              context,
                              'Uploading file...',
                              showLoading: true,
                            );
                            selectedUploadedFiles = selectedMedia
                                .map((m) => FFUploadedFile(
                                      name: m.storagePath.split('/').last,
                                      bytes: m.bytes,
                                      height: m.dimensions?.height,
                                      width: m.dimensions?.width,
                                      blurHash: m.blurHash,
                                    ))
                                .toList();

                            downloadUrls = (await Future.wait(
                              selectedMedia.map(
                                (m) async =>
                                    await uploadData(m.storagePath, m.bytes),
                              ),
                            ))
                                .where((u) => u != null)
                                .map((u) => u!)
                                .toList();
                          } finally {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            _model.isDataUploading_uploadDataPath = false;
                          }
                          if (selectedUploadedFiles.length ==
                                  selectedMedia.length &&
                              downloadUrls.length == selectedMedia.length) {
                            safeSetState(() {
                              _model.uploadedLocalFile_uploadDataPath =
                                  selectedUploadedFiles.first;
                              _model.uploadedFileUrl_uploadDataPath =
                                  downloadUrls.first;
                            });
                            showUploadMessage(context, 'Success!');
                          } else {
                            safeSetState(() {});
                            showUploadMessage(context, 'Failed to upload data');
                            return;
                          }
                        }
                      },
                      text: 'Attach File',
                      icon: Icon(
                        Icons.insert_drive_file_outlined,
                        size: 18.0,
                      ),
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconColor: FlutterFlowTheme.of(context).primary,
                        color: Colors.transparent,
                        textStyle:
                            FlutterFlowTheme.of(context).labelSmall.override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).accent4,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        // Show loading message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(kIsWeb 
                                ? 'Initializing speech recognition...' 
                                : 'Requesting microphone permission...'),
                            backgroundColor: FlutterFlowTheme.of(context).primary,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        
                        // Add a small delay to let the user see the message
                        await Future.delayed(Duration(milliseconds: 500));
                        
                        // Always try to initialize speech recognition
                        await _model.initSpeech();
                        
                        // For web, provide additional guidance if speech recognition fails
                        if (kIsWeb && !_model.isSpeechAvailable) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please allow microphone access when prompted by your browser. If you don\'t see a permission dialog, check your browser\'s microphone settings.'),
                              backgroundColor: FlutterFlowTheme.of(context).primary,
                              duration: Duration(seconds: 4),
                            ),
                          );
                        }
                        
                        if (_model.isSpeechAvailable) {
                          _model.toggleListening();
                          safeSetState(() {});
                          
                          // Show feedback message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_model.isListening 
                                  ? '🎤 Listening for speech... Speak now!' 
                                  : '✅ Speech recognition stopped'),
                              backgroundColor: _model.isListening 
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).secondaryText,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } else {
                          String message;
                          SnackBarAction? action;
                          
                          if (kIsWeb) {
                            message = 'Voice input is not available. Please ensure you are using Chrome, Edge, or Safari with microphone access enabled for skin analysis voice commands.';
                            action = SnackBarAction(
                              label: 'Retry',
                              textColor: Colors.white,
                              onPressed: () async {
                                await _model.initSpeech();
                                if (_model.isSpeechAvailable) {
                                  _model.toggleListening();
                                  safeSetState(() {});
                                }
                              },
                            );
                          } else {
                            // Check if permission is permanently denied
                            try {
                              var status = await Permission.microphone.status;
                              if (status.isPermanentlyDenied) {
                                message = 'Microphone access is permanently denied. Please enable it in device settings to use voice features.';
                                action = SnackBarAction(
                                  label: 'Settings',
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    await openAppSettings();
                                  },
                                );
                              } else {
                                message = 'Microphone permission denied. Please grant microphone access to use voice features.';
                                action = SnackBarAction(
                                  label: 'Settings',
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    await openAppSettings();
                                  },
                                );
                              }
                            } catch (e) {
                              message = 'Speech recognition is not available on this platform.';
                            }
                          }
                          
                          // Show error message if speech recognition is not available
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: FlutterFlowTheme.of(context).error,
                              duration: Duration(seconds: 5),
                              action: action,
                            ),
                          );
                        }
                      },
                      text: _model.isListening ? 'Listening...' : (_model.isSpeechAvailable ? 'Voice Mode' : 'Voice Mode'),
                      icon: Icon(
                        _model.isListening ? Icons.mic_off : Icons.mic_sharp,
                        size: 18.0,
                      ),
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconColor: _model.isListening 
                            ? FlutterFlowTheme.of(context).error
                            : FlutterFlowTheme.of(context).primary,
                        color: _model.isListening 
                            ? FlutterFlowTheme.of(context).error.withOpacity(0.1)
                            : Colors.transparent,
                        textStyle:
                            FlutterFlowTheme.of(context).labelSmall.override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: _model.isListening 
                              ? FlutterFlowTheme.of(context).error
                              : FlutterFlowTheme.of(context).accent4,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
                FlutterFlowIconButton(
                  borderRadius: 100.0,
                  buttonSize: 36.0,
                  fillColor: FlutterFlowTheme.of(context).primary,
                  icon: Icon(
                    Icons.send_outlined,
                    color: FlutterFlowTheme.of(context).info,
                    size: 16.0,
                  ),
                  onPressed: () async {
                    await widget.onNewMessage?.call();
                  },
                ),
              ],
            ),
          ].divide(SizedBox(height: 8.0)),
        ),
      ),
    );
  }
}
