import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// The navigation bar widget
class NavigationBarItem extends StatelessWidget {
  /// The navigation bar item constructor
  const NavigationBarItem({
    required this.assetUrl,
    super.key,
    this.onTap,
    this.label = '',
    this.isSelected = false,
  });

  /// The asset url
  final String assetUrl;

  /// The color

  /// The onTap function
  final VoidCallback? onTap;

  /// The label
  final String? label;

  /// The is selected
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetUrl,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.lightBlue : AppColors.grey,
              BlendMode.srcIn,
            ),
          ),
          label != ''
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    gapH4,
                    Text(label!).textxsBold.foregroundColor(
                        isSelected ? AppColors.lightBlue : AppColors.grey),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
