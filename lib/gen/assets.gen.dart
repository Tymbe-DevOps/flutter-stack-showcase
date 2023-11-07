/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/GintoNord-Black.otf
  String get gintoNordBlack => 'assets/fonts/GintoNord-Black.otf';

  /// File path: assets/fonts/GintoNormal-Bold.otf
  String get gintoNormalBold => 'assets/fonts/GintoNormal-Bold.otf';

  /// File path: assets/fonts/GintoNormal-Regular.otf
  String get gintoNormalRegular => 'assets/fonts/GintoNormal-Regular.otf';
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/arrow.svg
  SvgGenImage get arrow => const SvgGenImage('assets/icons/arrow.svg');

  /// File path: assets/icons/chevron_android.svg
  SvgGenImage get chevronAndroid =>
      const SvgGenImage('assets/icons/chevron_android.svg');

  /// File path: assets/icons/chevron_ios.svg
  SvgGenImage get chevronIos =>
      const SvgGenImage('assets/icons/chevron_ios.svg');

  /// File path: assets/icons/laptop.svg
  SvgGenImage get laptop => const SvgGenImage('assets/icons/laptop.svg');

  /// File path: assets/icons/mobile.svg
  SvgGenImage get mobile => const SvgGenImage('assets/icons/mobile.svg');

  /// File path: assets/icons/qr.svg
  SvgGenImage get qr => const SvgGenImage('assets/icons/qr.svg');

  /// File path: assets/icons/refresh.svg
  SvgGenImage get refresh => const SvgGenImage('assets/icons/refresh.svg');

  /// File path: assets/icons/search.png
  AssetGenImage get search => const AssetGenImage('assets/icons/search.png');

  /// File path: assets/icons/tablet.svg
  SvgGenImage get tablet => const SvgGenImage('assets/icons/tablet.svg');

  /// File path: assets/icons/watches.svg
  SvgGenImage get watches => const SvgGenImage('assets/icons/watches.svg');
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/apple.png
  AssetGenImage get apple => const AssetGenImage('assets/images/apple.png');

  /// File path: assets/images/error.png
  AssetGenImage get error => const AssetGenImage('assets/images/error.png');

  /// File path: assets/images/glass.png
  AssetGenImage get glass => const AssetGenImage('assets/images/glass.png');

  /// File path: assets/images/hands.png
  AssetGenImage get hands => const AssetGenImage('assets/images/hands.png');

  /// File path: assets/images/huawei.png
  AssetGenImage get huawei => const AssetGenImage('assets/images/huawei.png');

  /// File path: assets/images/samsung.png
  AssetGenImage get samsung => const AssetGenImage('assets/images/samsung.png');

  /// File path: assets/images/sony.png
  AssetGenImage get sony => const AssetGenImage('assets/images/sony.png');

  /// File path: assets/images/xiaomi.png
  AssetGenImage get xiaomi => const AssetGenImage('assets/images/xiaomi.png');
}

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// File path: assets/json/apple_devices_codes.json
  String get appleDevicesCodes => 'assets/json/apple_devices_codes.json';

  /// File path: assets/json/loading.json
  String get loading => 'assets/json/loading.json';
}

class $AssetsSplashGen {
  const $AssetsSplashGen();

  /// File path: assets/splash/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/splash/splash.png');
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonGen json = $AssetsJsonGen();
  static const $AssetsSplashGen splash = $AssetsSplashGen();
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
    String? package,
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

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
