import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? fit;
  final double? size;
  final double? width;
  final double? height;
  final LoadingErrorWidgetBuilder? errorWidget;
  final PlaceholderWidgetBuilder? placeHolderBuilder;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.size,
    this.width,
    this.errorWidget,
    this.placeHolderBuilder,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    var url = imageUrl;
    if (url == null || url.isEmpty) {
      return Container(
        width: width ?? size,
        height: height ?? size,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Icon(Icons.warning_amber),
      );
    }
    return CachedNetworkImage(
      width: width ?? size,
      height: height ?? size,
      fit: fit,
      imageUrl: url,
      placeholder: placeHolderBuilder ?? _placeHolder,
      errorWidget: errorWidget ?? _buildError,
    );
  }

  Widget _placeHolder(BuildContext context, String url) {
    return Container(color: Colors.transparent);
  }

  Widget _buildError(BuildContext context, String url, Object error) {
    return Container(
      width: width ?? size,
      height: height ?? size,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Icon(Icons.error),
    );
  }
}
