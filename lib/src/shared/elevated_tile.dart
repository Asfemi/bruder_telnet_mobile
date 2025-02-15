import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ElevatedTile extends StatelessWidget {
  const ElevatedTile({
    super.key,
    this.child,
    this.onPressed,
    this.leading = const SizedBox(),
    this.trailing = const SizedBox(),
  });

  final VoidCallback? onPressed;
  final Widget? child;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Sizes.p16),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(Sizes.p16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(Sizes.p16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leading!,
                trailing!,
              ],
            ),
      ),
    );
  }
}
