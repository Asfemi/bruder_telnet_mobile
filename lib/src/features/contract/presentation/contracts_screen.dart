import 'package:bruder_telnet_mobile/gen/assets.gen.dart';
import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/core/router/app_router.dart';
import 'package:bruder_telnet_mobile/src/shared/data_consumption_widget.dart';
import 'package:bruder_telnet_mobile/src/shared/elevated_tile.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContractsScreen extends HookConsumerWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasContracts = useState(true);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: hasContracts.value
                ? MediaQuery.of(context).size.height * 0.37
                : MediaQuery.of(context).size.height * 0.28,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(Sizes.p16),
                  height: hasContracts.value
                      ? MediaQuery.of(context).size.height * 0.32
                      : MediaQuery.of(context).size.height * 0.23,
                  color: AppColors.lightBlue,
                  child: SafeArea(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Hi')
                                .displayxsBold
                                .foregroundColor(AppColors.white),
                            const Text('User')
                                .textmdBold
                                .foregroundColor(AppColors.white),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                DataConsumptionUsageWidget(
                  topMargin: 150,
                  max: 30,
                  current: 3,
                  value: 0.1,
                  hasContracts: hasContracts.value,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: hasContracts.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Verträge').textmdBold,
                      gapH16,
                      ElevatedTile(
                        onPressed: () => context.pushNamed(
                          AppRoutes.contractDetail.name,
                          pathParameters: {
                            'contractId': 'P3400',
                          },
                        ),
                        leading: const Text('P3400').textxlBold,
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Activ')
                                .textsmRegular
                                .foregroundColor(AppColors.lightBlue),
                            gapH8,
                            const Text('22 June 2024').textmdBold,
                          ],
                        ),
                      ),
                      gapH16,
                      ElevatedTile(
                        onPressed: () => context.pushNamed(
                          AppRoutes.contractDetail.name,
                          pathParameters: {
                            'contractId': 'P3400',
                          },
                        ),
                        leading: const Text('P3400').textxlBold,
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Activ')
                                .textsmRegular
                                .foregroundColor(AppColors.lightBlue),
                            gapH8,
                            const Text('22 June 2024').textmdBold,
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(Assets.noContractImagePng.path),
                      ),
                      gapH16,
                      const Text('keine Verträge gefunden').textxlBold
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
