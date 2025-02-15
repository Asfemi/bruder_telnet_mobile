import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_button.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_textfield.dart';
import 'package:bruder_telnet_mobile/src/shared/secondary_button.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zod_validation/zod_validation.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Sizes.p16, vertical: Sizes.p32),
            child: Center(
              child: Column(
                children: [
                  gapH48,
                  const Text('Passwort vergessen?').displaysmBold,
                  gapH24,
                  const Text(
                    'Bitte geben Sie Ihre Email ein, damit wir Ihnen den Wiederherstellungscode zusenden können.',
                    textAlign: TextAlign.center,
                  ).textsmRegular.foregroundColor(
                        AppColors.lightBlue,
                      ),
                  gapH48,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryTextfield(
                        controller: emailController,
                        validator: Zod().required().email().build,
                        label: 'Email',
                        hintText: 'Email eingeben',
                      ),
                      gapH48,
                      PrimaryButton(
                        onPressed: () {},
                        text: 'Code senden',
                      ),
                      gapH16,
                      SecondaryButton(
                        onPressed: () => context.pop(),
                        text: 'Gehe zurück',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
