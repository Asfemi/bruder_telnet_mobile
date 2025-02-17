import 'package:bruder_telnet_mobile/gen/assets.gen.dart';
import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/features/auth/presentation/controller/auth_controller.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_button.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_textfield.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zod_validation/zod_validation.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    ref.listen<AsyncValue<void>>(authControllerProvider, (_, state) {
      state.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
            ),
          );
        },
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('registration successful'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Sizes.p16, vertical: Sizes.p32),
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  children: [
                    Image.asset(Assets.bruderEmblem.path),
                    gapH48,
                    const Text('Registrierung').displaysmBold,
                    gapH48,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryTextfield(
                          controller: fullNameController,
                          validator: Zod().required().min(2).build,
                          label: 'Vollständiger Name',
                          hintText: 'Geben Sie Ihren vollständigen Namen ein',
                        ),
                        gapH16,
                        PrimaryTextfield(
                          controller: emailController,
                          validator: Zod().required().email().build,
                          label: 'E-Mail',
                          hintText: 'Geben Sie Ihre E-Mail-Adresse ein',
                        ),
                        gapH16,
                        PrimaryTextfield(
                          controller: phoneController,
                          validator: Zod().required().phone().build,
                          label: 'Telefonnummer',
                          hintText: '+33xxxxxxxxxxx',
                        ),
                        gapH16,
                        PrimaryTextfield(
                          controller: passwordController,
                          validator: Zod().required().min(8).build,
                          textInputAction: TextInputAction.done,
                          label: 'Passwort',
                          hintText: 'Geben Sie Ihr Passwort ein',
                          obscureText: true,
                        ),
                        gapH48,
                        Consumer(
                          builder: (context, ref, child) {
                            final isLoading =
                                ref.watch(authControllerProvider).isLoading;
                            return PrimaryButton(
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                      if (formKey.currentState!.validate()) {
                                        await ref
                                            .read(
                                                authControllerProvider.notifier)
                                            .signUp(
                                              email:
                                                  emailController.text.trim(),
                                              password: passwordController.text,
                                              fullName: fullNameController.text
                                                  .trim(),
                                              phone:
                                                  phoneController.text.trim(),
                                            );
                                      }
                                    },
                              text: isLoading
                                  ? 'Registrieren...'
                                  : 'Registrieren',
                            );
                          },
                        ),
                        gapH16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Haben Sie bereits ein Konto?')
                                .textsmRegular
                                .foregroundColor(AppColors.black),
                            TextButton(
                              onPressed: () => context.pop(),
                              child: const Text('Anmelden')
                                  .textsmRegular
                                  .foregroundColor(AppColors.lightBlue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
