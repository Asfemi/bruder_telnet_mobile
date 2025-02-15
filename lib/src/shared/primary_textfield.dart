import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrimaryTextfield extends HookConsumerWidget {
  const PrimaryTextfield({
    super.key,
    this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.textInputAction,
    this.suffixIcon,
    this.onTap,
    this.validator,
    this.label,
    this.hintText,
    this.maxLines = 1,
    this.keyboardType,
    this.prefixIcon,
    this.textCapitalization,
    this.focusNode,
  });

  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final String? label;
  final String? hintText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hideText = useState(true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!).textsmRegular.foregroundColor(AppColors.black),
          gapH4,
        ],
        TextFormField(
          focusNode: focusNode,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          onTap: onTap,
          keyboardType: keyboardType,
          readOnly: readOnly,
          validator: validator,
          controller: controller,
          maxLines: maxLines,
          obscureText: obscureText ? hideText.value : false,
          textInputAction: textInputAction ?? TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            errorMaxLines: 2,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon ??
                (obscureText
                    ? IconButton(
                        icon: Icon(
                          hideText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.grey,
                        ),
                        onPressed: () {
                          hideText.value = !hideText.value;
                        },
                      )
                    : null),
            hintText: hintText,
            hintStyle: GoogleFonts.exo(
              color: AppColors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 2,
                color: AppColors.lightGrey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 2,
                color: AppColors.lightGrey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: readOnly
                  ? const BorderSide(
                      width: 2,
                      color: AppColors.lightGrey,
                    )
                  : const BorderSide(
                      width: 2,
                      color: AppColors.lightGrey,
                    ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
