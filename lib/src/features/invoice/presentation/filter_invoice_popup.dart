import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/extensions/date_extensions.dart';
import 'package:bruder_telnet_mobile/src/features/invoice/presentation/date_picker_tile.dart';
import 'package:bruder_telnet_mobile/src/core/router/app_router.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_button.dart';
import 'package:bruder_telnet_mobile/src/shared/primary_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterInvoicePopup extends HookConsumerWidget {
  const FilterInvoicePopup({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFromDateText = useState('');
    final selectedFromDate = useState(DateTime.now());
    final selectedToDateText = useState('');
    final selectedToDate = useState(DateTime.now());

    return PrimaryDialog(
      title: 'Choose Date',
      child: Column(
        children: [
          Row(
            children: [
              DatePickerTile(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    selectedFromDate.value = date;
                    selectedFromDateText.value = date.toDayMonth();

                    if (selectedToDate.value.isBefore(date)) {
                      selectedToDate.value = date;
                      selectedToDateText.value = date.toDayMonth();
                    }
                  }
                },
                hintText: 'Select start date',
                label: 'Start Date',
                value: selectedFromDateText.value,
              ),
              gapW16,
              DatePickerTile(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedFromDate.value,
                    firstDate: selectedFromDate.value,
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    selectedToDate.value = date;
                    selectedToDateText.value = date.toDayMonth();
                  }
                },
                hintText: 'Select end date',
                label: 'End Date',
                value: selectedToDateText.value,
              ),
            ],
          ),
          gapH24,
          PrimaryButton(
            onPressed: () {
              context.pop();
              context.pushNamed(
                AppRoutes.invoiceFilterResult.name,
                pathParameters: {
                  'filterFromDate': selectedFromDateText.value,
                  'filterToDate': selectedToDateText.value,
                },
              );
              selectedFromDateText.value = '';
              selectedToDateText.value = '';
            },
            text: 'Select',
          ),
        ],
      ),
    );
  }
}
