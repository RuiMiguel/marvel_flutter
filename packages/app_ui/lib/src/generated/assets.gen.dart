/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/close.png
  AssetGenImage get close => const AssetGenImage('assets/images/close.png');

  /// File path: assets/images/error.jpeg
  AssetGenImage get error => const AssetGenImage('assets/images/error.jpeg');

  $AssetsImagesMenuGen get menu => const $AssetsImagesMenuGen();

  /// File path: assets/images/mjolnir.png
  AssetGenImage get mjolnir => const AssetGenImage('assets/images/mjolnir.png');

  /// File path: assets/images/placeholder.png
  AssetGenImage get placeholder =>
      const AssetGenImage('assets/images/placeholder.png');

  /// File path: assets/images/wait.jpeg
  AssetGenImage get wait => const AssetGenImage('assets/images/wait.jpeg');

  /// List of all assets
  List<AssetGenImage> get values => [close, error, mjolnir, placeholder, wait];
}

class $AssetsImagesMenuGen {
  const $AssetsImagesMenuGen();

  /// File path: assets/images/menu/captain-america.png
  AssetGenImage get captainAmerica =>
      const AssetGenImage('assets/images/menu/captain-america.png');

  /// File path: assets/images/menu/hulk.png
  AssetGenImage get hulk => const AssetGenImage('assets/images/menu/hulk.png');

  /// File path: assets/images/menu/iron-man.png
  AssetGenImage get ironMan =>
      const AssetGenImage('assets/images/menu/iron-man.png');

  /// File path: assets/images/menu/thor.png
  AssetGenImage get thor => const AssetGenImage('assets/images/menu/thor.png');

  /// List of all assets
  List<AssetGenImage> get values => [captainAmerica, hulk, ironMan, thor];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package = 'app_ui',
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => 'packages/app_ui/$_assetName';
}
