import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class PrimaryChip extends StatelessWidget {
  const PrimaryChip({
    super.key,
    required this.text,
    required this.onSelected,
    required this.isSelected,
    this.onDeleted,
  });

  final String text;
  final VoidCallback onSelected;
  final bool isSelected;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Chip(
        onDeleted: onDeleted,
        deleteIcon: const Icon(
          Icons.close,
          color: AppColors.white,
        ),
        backgroundColor: isSelected ? AppColors.lightBlue : AppColors.white,
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p20, vertical: Sizes.p8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        label: Text(text)
            .textsmBold
            .foregroundColor(isSelected ? AppColors.white : AppColors.black),
      ),
    );
  }
}
