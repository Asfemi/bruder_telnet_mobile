import 'package:bruder_telnet_mobile/gen/assets.gen.dart';
import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DatePickerTile extends StatelessWidget {
  const DatePickerTile({
    super.key,
    this.onTap,
    required this.label,
    required this.value,
    this.hintText = '',
  });

  final VoidCallback? onTap;
  final String label;
  final String? hintText;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label).textsmRegular,
          gapH4,
          InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.p16,
                horizontal: Sizes.p8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.lightGrey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(Sizes.p8),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.calendar,
                    width: Sizes.p24,
                    height: Sizes.p24,
                  ),
                  gapW8,
                  Flexible(
                    child: Text(
                      value == '' ? hintText! : value,
                      overflow: TextOverflow.ellipsis,
                    ).textxsRegular,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
