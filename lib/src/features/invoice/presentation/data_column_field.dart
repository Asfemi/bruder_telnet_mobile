import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DataColumnField extends StatelessWidget {
  const DataColumnField({
    super.key,
    required this.assetUrl,
    required this.data,
    required this.value,
  });

  final String assetUrl;
  final String data;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(assetUrl),
        gapH8,
        Text(data).textxsRegular,
        gapH8,
        Text(value).textmdBold,
      ],
    );
  }
}
