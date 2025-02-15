import 'package:bruder_telnet_mobile/gen/assets.gen.dart';
import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/features/invoice/presentation/data_column_field.dart';
import 'package:bruder_telnet_mobile/src/features/invoice/presentation/primary_chip.dart';
import 'package:bruder_telnet_mobile/src/core/router/app_router.dart';
import 'package:bruder_telnet_mobile/src/shared/elevated_tile.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_vertical_divider.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvoiceFilterResultScreen extends HookConsumerWidget {
  const InvoiceFilterResultScreen({
    super.key,
    required this.filterFromDate,
    required this.filterToDate,
  });

  final String filterFromDate;
  final String filterToDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterDate = '$filterFromDate - $filterToDate';
    final selectedChip = useState(filterDate);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices').textxlBold,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PrimaryChip(
                    isSelected: selectedChip.value == filterDate,
                    onSelected: () {
                      selectedChip.value = filterDate;
                    },
                    text: filterDate,
                    onDeleted: () => context.pop(),
                  ),
                  PrimaryChip(
                    isSelected: selectedChip.value == 'weekly',
                    onSelected: () {
                      selectedChip.value = 'weekly';
                    },
                    text: 'Weekly',
                  ),
                  PrimaryChip(
                    isSelected: selectedChip.value == 'monthly',
                    onSelected: () {
                      selectedChip.value = 'monthly';
                    },
                    text: 'Monthly',
                  ),
                ],
              ),
            ),
            gapH16,
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
            ),
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
