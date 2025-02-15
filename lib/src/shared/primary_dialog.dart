import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrimaryDialog extends StatelessWidget {
  const PrimaryDialog({
    super.key,
    required this.child,
    this.title = '',
  });

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(Sizes.p16),
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
      child: Container(
        padding: const EdgeInsets.all(Sizes.p16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.p12),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title!).textmdBold,
                InkWell(
                  onTap: () => context.pop(),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            gapH24,
            child,
          ],
        ),
      ),
    );
  }
}
