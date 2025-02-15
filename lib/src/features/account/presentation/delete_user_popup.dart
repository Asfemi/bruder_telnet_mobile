import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/router/app_router.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_button.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_dialog.dart';
import 'package:bruder_telnet_mobile/src/shared/secondary_button.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteUserPopup extends StatelessWidget {
  const DeleteUserPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryDialog(
      title: 'Delete Account',
      child: Column(
        children: [
          const Text(
            'Are you sure you want to delete your account?',
          ).textmdRegular,
          gapH16,
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  onPressed: () {
                    context.pop();
                  },
                  text: 'Cancel',
                ),
              ),
              gapW16,
              Expanded(
                child: PrimaryButton(
                  onPressed: () {
                    context.pop();
                    context.goNamed(AppRoutes.login.name);
                  },
                  text: 'Delete',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
