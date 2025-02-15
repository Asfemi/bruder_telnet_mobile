import 'package:bruder_telnet_mobile/gen/assets.gen.dart';
import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/features/invoice/presentation/data_column_field.dart';
import 'package:bruder_telnet_mobile/src/features/invoice/presentation/filter_invoice_popup.dart';
import 'package:bruder_telnet_mobile/src/features/invoice/presentation/primary_chip.dart';
import 'package:bruder_telnet_mobile/src/core/router/app_router.dart';
import 'package:bruder_telnet_mobile/src/shared/elevated_tile.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_vertical_divider.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvoicesScreen extends HookConsumerWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedChip = useState('all');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices').textxlBold,
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const FilterInvoicePopup(),
            ),
            icon: SvgPicture.asset(Assets.filter),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                PrimaryChip(
                  isSelected: selectedChip.value == 'all',
                  onSelected: () {
                    selectedChip.value = 'all';
                  },
                  text: 'All',
                ),
                PrimaryChip(
                  isSelected: selectedChip.value == 'unpaid',
                  onSelected: () {
                    selectedChip.value = 'unpaid';
                  },
                  text: 'Unpaid',
                ),
                PrimaryChip(
                  isSelected: selectedChip.value == 'paid',
                  onSelected: () {
                    selectedChip.value = 'paid';
                  },
                  text: 'Paid',
                ),
              ],
            ),
            gapH24,
            ElevatedTile(
              onPressed: () => context.pushNamed(
                AppRoutes.invoiceDetail.name,
                pathParameters: {
                  'invoiceId': 'P3400',
                },
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('P3400').textmdBold,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('bill used').textxsRegular,
                          const Text('\$30')
                              .textmdBold
                              .foregroundColor(AppColors.lightBlue),
                        ],
                      ),
                    ],
                  ),
                  gapH16,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DataColumnField(
                        assetUrl: Assets.globe,
                        data: 'Data',
                        value: '30GB',
                      ),
                      gapW16,
                      PrimaryVerticalDivider(),
                      gapW16,
                      DataColumnField(
                        assetUrl: Assets.globe,
                        data: 'Minutes',
                        value: '2300',
                      ),
                      gapW16,
                      PrimaryVerticalDivider(),
                      gapW16,
                      DataColumnField(
                        assetUrl: Assets.globe,
                        data: 'SMS',
                        value: '4000',
                      ),
                      gapW16,
                      PrimaryVerticalDivider(),
                      gapW16,
                      DataColumnField(
                        assetUrl: Assets.globe,
                        data: 'MMS',
                        value: '4000',
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ).paddingOnly(
          left: Sizes.p16,
          right: Sizes.p16,
          bottom: Sizes.p16,
        ),
      ),
    );
  }
}
