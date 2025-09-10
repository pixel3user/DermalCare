import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'image_attachment_model.dart';
export 'image_attachment_model.dart';

class ImageAttachmentWidget extends StatefulWidget {
  const ImageAttachmentWidget({
    super.key,
    this.onDelete,
    this.imageUrl,
    this.imageFile,
  });

  final Future Function()? onDelete;
  final String? imageUrl;
  final FFUploadedFile? imageFile;

  @override
  State<ImageAttachmentWidget> createState() => _ImageAttachmentWidgetState();
}

class _ImageAttachmentWidgetState extends State<ImageAttachmentWidget> {
  late ImageAttachmentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ImageAttachmentModel());

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
      width: 64.0,
      height: 64.0,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: _buildImage(),
          ),
          Align(
            alignment: AlignmentDirectional(1.25, -1.25),
            child: Container(
              width: 16.0,
              height: 16.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).accent4,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await widget.onDelete?.call();
                },
                child: Icon(
                  Icons.close,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 10.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    // Use imageFile if available (for local preview), otherwise use imageUrl
    if (widget.imageFile != null && widget.imageFile!.bytes != null && widget.imageFile!.bytes!.isNotEmpty) {
      return Image.memory(
        widget.imageFile!.bytes!,
        width: 64.0,
        height: 64.0,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      );
    } else if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return Image.network(
        widget.imageUrl!,
        width: 64.0,
        height: 64.0,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 64.0,
            height: 64.0,
            color: FlutterFlowTheme.of(context).accent4,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                strokeWidth: 2.0,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      );
    } else {
      return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      width: 64.0,
      height: 64.0,
      color: FlutterFlowTheme.of(context).accent4,
      child: Icon(
        Icons.broken_image,
        color: FlutterFlowTheme.of(context).secondaryText,
        size: 24.0,
      ),
    );
  }
}
