import 'package:bruder_telnet_mobile/gen/assets.gen.dart';
import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/features/auth/presentation/controller/auth_controller.dart';
import 'package:bruder_telnet_mobile/src/core/router/app_router.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_button.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_textfield.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zod_validation/zod_validation.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
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
          context.pushNamed(AppRoutes.contracts.name);
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
                    const Text('Login').displaysmBold,
                    gapH48,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryTextfield(
                          controller: emailController,
                          validator: Zod().required().email().build,
                          label: 'Email',
                          hintText: 'EMail eingeben',
                        ),
                        gapH16,
                        PrimaryTextfield(
                          controller: passwordController,
                          validator: Zod().required().min(8).build,
                          textInputAction: TextInputAction.done,
                          label: 'Passwort',
                          hintText: '********',
                          obscureText: true,
                        ),
                        gapH16,
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => context
                                .pushNamed(AppRoutes.forgotPassword.name),
                            child: const Text('Passwort vergessen?')
                                .textsmRegular
                                .foregroundColor(
                                  AppColors.lightBlue,
                                ),
                          ),
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
                                            .signIn(
                                              email:
                                                  emailController.text.trim(),
                                              password: passwordController.text,
                                            );
                                      }
                                    },
                              text: isLoading ? 'Anmelden...' : 'Anmelden',
                            );
                          },
                        ),
                        gapH16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Sie haben kein Konto?')
                                .textsmRegular
                                .foregroundColor(AppColors.black),
                            TextButton(
                              onPressed: () =>
                                  context.pushNamed(AppRoutes.register.name),
                              child: const Text('Registrieren')
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
