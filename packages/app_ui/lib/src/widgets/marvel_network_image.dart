import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';

class MarvelNetworkImage extends StatelessWidget {
  const MarvelNetworkImage({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheManager: context.read<CacheManager?>(),
      imageBuilder: (context, imageProvider) => DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => MarvelIcons.placeholder.image(
        fit: BoxFit.contain,
      ),
      errorWidget: (context, url, dynamic error) => MarvelIcons.error.image(
        fit: BoxFit.contain,
      ),
    );
  }
}
