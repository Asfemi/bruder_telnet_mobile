/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class Assets {
  Assets._();

  static const AssetGenImage bruderEmblem =
      AssetGenImage('assets/bruder_emblem.png');
  static const String calendar = 'assets/calendar.svg';
  static const String call = 'assets/call.svg';
  static const String customerSupport = 'assets/customer_support.svg';
  static const String delete = 'assets/delete.svg';
  static const String edit = 'assets/edit.svg';
  static const String filter = 'assets/filter.svg';
  static const String globe = 'assets/globe.svg';
  static const String homeIcon = 'assets/home_icon.svg';
  static const String info = 'assets/info.svg';
  static const String invoiceIcon = 'assets/invoice_icon.svg';
  static const String logout = 'assets/logout.svg';
  static const String mail = 'assets/mail.svg';
  static const AssetGenImage noContractImagePng =
      AssetGenImage('assets/no_contract_image.png');
  static const String noContractImageSvg = 'assets/no_contract_image.svg';
  static const String profileIcon = 'assets/profile_icon.svg';
  static const String sms = 'assets/sms.svg';

  /// List of all assets
  List<dynamic> get values => [
        bruderEmblem,
        calendar,
        call,
        customerSupport,
        delete,
        edit,
        filter,
        globe,
        homeIcon,
        info,
        invoiceIcon,
        logout,
        mail,
        noContractImagePng,
        noContractImageSvg,
        profileIcon,
        sms
      ];
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
