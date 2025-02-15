import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.text = '',
    this.backgroundColor = AppColors.lightBlue,
    this.textColor = AppColors.white,
    this.iconUrl = '',
  });

  final String? iconUrl;
  final VoidCallback? onPressed;
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconUrl != ''
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        iconUrl!,
                        height: Sizes.p24,
                        width: Sizes.p24,
                      ),
                      gapW8,
                    ],
                  )
                : const SizedBox(),
            Text(text!).textmdBold.foregroundColor(textColor),
          ],
        ),
      ),
    );
  }
}
