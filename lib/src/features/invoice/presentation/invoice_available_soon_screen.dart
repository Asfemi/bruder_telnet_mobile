import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvoiceAvailableSoonScreen extends HookConsumerWidget {
  const InvoiceAvailableSoonScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rechnungen').textxlBold,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(Sizes.p48),
                decoration: BoxDecoration(
                  color: AppColors.brown,
                  borderRadius: BorderRadius.circular(Sizes.p8),
                ),
                child: Center(
                  child: const Text(
                    'Funktion demnächst verfügbar. \nAktuell erhalten sie ihre Rechnung per Mail.',
                    textAlign: TextAlign.center,
                  ).textmdBold.foregroundColor(AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
