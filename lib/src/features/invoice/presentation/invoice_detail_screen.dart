import 'package:bruder_telnet_mobile/gen/assets.gen.dart';
import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/features/invoice/presentation/invoice_card_tile.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_button.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvoiceDetailScreen extends HookConsumerWidget {
  const InvoiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('P3400').textxlBold,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              gapH32,
              Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    height: 200,
                    width: 200,
                    child: CurvedCircularProgressIndicator(
                      animationDuration: Duration(seconds: 1),
                      value: 0.7,
                      backgroundColor: AppColors.brownAccent,
                      color: AppColors.brown,
                      strokeWidth: Sizes.p16,
                    ),
                  ),
                  Column(
                    children: [
                      const Text('Mobile Data').textxsRegular,
                      gapH4,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('12GB').displayxsBold,
                          gapW4,
                          const Text('GB').textxsRegular,
                        ],
                      ),
                      gapH4,
                      const Text('Remaining').textxsRegular,
                    ],
                  )
                ],
              ),
              gapH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Charges').textmdBold,
                  const Text('30 USD')
                      .textmdBold
                      .foregroundColor(AppColors.lightBlue),
                ],
              ),
              gapH4,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Basic Fee').textmdBold,
                  const Text('30 USD')
                      .textmdBold
                      .foregroundColor(AppColors.lightBlue),
                ],
              ),
              gapH24,
              const Row(
                children: [
                  InvoiceCardTile(
                    assetUrl: Assets.call,
                    title: 'Overall Calls',
                    data: 'MINS',
                    value: '200000',
                  ),
                  gapW16,
                  InvoiceCardTile(
                    assetUrl: Assets.globe,
                    title: 'Overall Data',
                    data: 'GBs',
                    value: '24.054',
                  ),
                ],
              ),
              gapH16,
              const Row(
                children: [
                  InvoiceCardTile(
                    assetUrl: Assets.call,
                    title: 'Overall Texts',
                    data: 'SMS',
                    value: '230000',
                  ),
                  gapW16,
                  InvoiceCardTile(
                    assetUrl: Assets.globe,
                    title: 'Overall MMS',
                    data: 'MMS',
                    value: '2300',
                  ),
                ],
              ),
              gapH48,
              PrimaryButton(
                onPressed: () {},
                text: 'Downnload Invoice',
              )
            ],
          ),
        ),
      ).paddingOnly(
        left: Sizes.p16,
        right: Sizes.p16,
        bottom: Sizes.p16,
      ),
    );
  }
}
