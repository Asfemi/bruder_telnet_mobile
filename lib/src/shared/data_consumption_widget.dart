import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class DataConsumptionUsageWidget extends StatelessWidget {
  const DataConsumptionUsageWidget({
    super.key,
    this.value,
    this.max,
    this.current,
    this.topMargin = 187,
    this.hasContracts = true,
  });

  final double? value;
  final int? max;
  final int? current;
  final double? topMargin;
  final bool? hasContracts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.p16),
      margin: EdgeInsets.fromLTRB(Sizes.p16, topMargin!, Sizes.p16, Sizes.p16),
      height: hasContracts!
          ? MediaQuery.of(context).size.height * 0.17
          : MediaQuery.of(context).size.height * 0.07,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Sizes.p16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: hasContracts!
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Maximales Datenvolumen').textsmBold,
                    Text('$max GB').textsmBold,
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('aktuelles Datenvolumen').textsmBold,
                    Text('$current GB').textsmBold,
                  ],
                ),
                gapH4,
                LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(Sizes.p8),
                  minHeight: Sizes.p8,
                  value: value,
                  backgroundColor: AppColors.brownAccent,
                  color: AppColors.brown,
                )
              ],
            )
          : Center(
              child: const Text(
              'Kein aktives Konto derzeit',
            ).textmdBold),
    );
  }
}
