import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/shared/elevated_tile.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InvoiceCardTile extends StatelessWidget {
  const InvoiceCardTile({
    super.key,
    required this.assetUrl,
    required this.title,
    required this.data,
    required this.value,
  });

  final String assetUrl;
  final String title;
  final String data;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedTile(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  assetUrl,
                  colorFilter:
                      const ColorFilter.mode(AppColors.brown, BlendMode.srcIn),
                ),
                gapW8,
                Text(title).textxsRegular,
              ],
            ),
            gapH16,
            Text(value).textxlBold,
            gapH4,
            Text(data).textxsRegular.foregroundColor(AppColors.brown)
          ],
        ),
      ),
    );
  }
}
