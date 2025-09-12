import '/components/buttons/suggestion_button/suggestion_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'empty_chat_state_model.dart';
export 'empty_chat_state_model.dart';

class EmptyChatStateWidget extends StatefulWidget {
  const EmptyChatStateWidget({
    super.key,
    this.onItemPress,
    this.onSkinAnalysis,
    this.onUploadPhoto,
    this.onSkincareTips,
    this.onProductRecommendations,
  });

  final Future Function()? onItemPress;
  final Future Function()? onSkinAnalysis;
  final Future Function()? onUploadPhoto;
  final Future Function()? onSkincareTips;
  final Future Function()? onProductRecommendations;

  @override
  State<EmptyChatStateWidget> createState() => _EmptyChatStateWidgetState();
}

class _EmptyChatStateWidgetState extends State<EmptyChatStateWidget> {
  late EmptyChatStateModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyChatStateModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          width: 440.0,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hi! I\'m your AI skincare assistant',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineLarge.override(
                      font: GoogleFonts.interTight(
                        fontWeight: FlutterFlowTheme.of(context)
                            .headlineLarge
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineLarge
                            .fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).headlineLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                    ),
              ),
              Text(
                'Ask me anything about your skin! I can help analyze skin concerns, recommend products, track your skincare routine, and provide personalized advice for healthier skin.',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).labelLarge.override(
                      font: GoogleFonts.interTight(
                        fontWeight:
                            FlutterFlowTheme.of(context).labelLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelLarge.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).labelLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelLarge.fontStyle,
                    ),
              ),
            ].divide(SizedBox(height: 16.0)),
          ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width < kBreakpointSmall
              ? (MediaQuery.sizeOf(context).width * 0.95)
              : 620.0,
          constraints: BoxConstraints(
            maxHeight: 160.0,
          ),
          decoration: BoxDecoration(),
          child: MasonryGridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            itemCount: 4,
            itemBuilder: (context, index) {
              return [
                () => wrapWithModel(
                      model: _model.suggestionButtonModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: SuggestionButtonWidget(
                        label: 'Skin Analysis',
                        icon: Icon(
                          Icons.face_retouching_natural,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                        onClick: () async {
                          await widget.onSkinAnalysis?.call();
                        },
                      ),
                    ),
                () => wrapWithModel(
                      model: _model.suggestionButtonModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: SuggestionButtonWidget(
                        label: 'Upload Photo',
                        icon: Icon(
                          Icons.camera_alt,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                        onClick: () async {
                          await widget.onUploadPhoto?.call();
                        },
                      ),
                    ),
                () => wrapWithModel(
                      model: _model.suggestionButtonModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: SuggestionButtonWidget(
                        label: 'Skincare Tips',
                        icon: Icon(
                          Icons.lightbulb_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                        onClick: () async {
                          await widget.onSkincareTips?.call();
                        },
                      ),
                    ),
                () => wrapWithModel(
                      model: _model.suggestionButtonModel4,
                      updateCallback: () => safeSetState(() {}),
                      child: SuggestionButtonWidget(
                        label: 'Product Recs',
                        icon: Icon(
                          Icons.shopping_bag,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                        onClick: () async {
                          await widget.onProductRecommendations?.call();
                        },
                      ),
                    ),
              ][index]();
            },
          ),
        ),
      ].divide(SizedBox(height: 24.0)),
    ),
    );
  }
}
