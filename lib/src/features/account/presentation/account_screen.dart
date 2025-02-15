import 'package:bruder_telnet_mobile/gen/assets.gen.dart';
import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/features/account/presentation/delete_user_popup.dart';
import 'package:bruder_telnet_mobile/src/core/router/app_router.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_button.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends HookConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konto').textxlBold,
      ),
      body: ListView(
        padding: const EdgeInsets.all(Sizes.p16),
        children: [
          ListTile(
            onTap: () => context.pushNamed(AppRoutes.updateProfile.name),
            leading: SvgPicture.asset(Assets.edit),
            title: const Text('Profil bearbeiten').textmdBold,
            trailing:
                const Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          const Divider(
            color: AppColors.grey,
          ),
          ListTile(
            onTap: () => context.pushNamed(AppRoutes.faq.name),
            leading: SvgPicture.asset(Assets.info),
            title: const Text('FAQs').textmdBold,
            trailing:
                const Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          const Divider(
            color: AppColors.grey,
          ),
          ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (context) {
                return const DeleteUserPopup();
              },
            ),
            leading: SvgPicture.asset(Assets.delete),
            title: const Text('Konto löschen').textmdBold,
            trailing:
                const Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          const Divider(
            color: AppColors.grey,
          ),
          ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (context) {
                return const DeleteUserPopup();
              },
            ),
            leading: SvgPicture.asset(Assets.delete),
            title: const Text('Hier Vertrag Kündigen.').textmdBold,
            trailing:
                const Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          const Divider(
            color: AppColors.grey,
          ),
          ListTile(
            onTap: () => context.goNamed(AppRoutes.login.name),
            leading: SvgPicture.asset(Assets.logout),
            title: const Text('Logout').textmdBold,
            trailing:
                const Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          gapH48,
          PrimaryButton(
            onPressed: () => launchUrl(Uri.parse('tel:+039237699028')),
            iconUrl: Assets.customerSupport,
            text: 'Unterstützung anrufen',
          ),
          gapH32,
          PrimaryButton(
            backgroundColor: const Color(0xFF25D366),
            onPressed: () => launchUrl(Uri.parse('https://wa.me/039237699028')),
            iconUrl: Assets.customerSupport,
            text: 'WhatsApp schreiben',
          ),
          gapH32,
          const Text(
            'Montag Dienstag Donnerstand Freitag 9:00-18:00 und Mittwoch Samstag 9:00-12:00',
            textAlign: TextAlign.center,
          ).paddingSymmetric(horizontal: Sizes.p32).textmdRegular,
        ],
      ),
    );
  }
}
