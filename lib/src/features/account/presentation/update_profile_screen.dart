import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_button.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_textfield.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zod_validation/zod_validation.dart';

class UpdateProfileScreen extends HookConsumerWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullNameController = useTextEditingController(
      text: 'John Doe',
    );
    final phoneController = useTextEditingController(
      text: '1234567890',
    );
    final emailController = useTextEditingController(
      text: 'johndoegmail.com',
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil bearbeiten').textxlBold,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryTextfield(
              label: 'Benutzername',
              validator: Zod().required().min(2).build,
              hintText: 'Geben Sie Ihren vollständigen Namen ein',
              controller: fullNameController,
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
              controller: emailController,
              validator: Zod().required().email().build,
              label: 'Email',
              hintText: 'Email eingeben',
              textInputAction: TextInputAction.done,
            ),
            gapH48,
            PrimaryButton(
              onPressed: () => context.pop(),
              text: 'Änderungen speichern',
            )
          ],
        ).padding(Sizes.p16),
      ),
    );
  }
}
