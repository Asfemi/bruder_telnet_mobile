import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:flutter/material.dart';

class PrimaryVerticalDivider extends StatelessWidget {
  const PrimaryVerticalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 1,
      color: AppColors.lightGrey,
    );
  }
}
