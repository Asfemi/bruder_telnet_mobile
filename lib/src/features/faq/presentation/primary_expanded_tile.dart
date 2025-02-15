import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class PrimaryExpandedTile extends StatelessWidget {
  const PrimaryExpandedTile({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.brown,
        borderRadius: BorderRadius.circular(Sizes.p8),
      ),
      child: ExpansionTile(
        iconColor: AppColors.white,
        collapsedIconColor: AppColors.white,
        title: Text(title).textmdBold.foregroundColor(AppColors.white),
        children: [
          Text(content)
              .textxsRegular
              .foregroundColor(AppColors.white)
              .paddingOnly(left: Sizes.p16, right: Sizes.p16, bottom: Sizes.p16)
        ],
      ),
    );
  }
}
