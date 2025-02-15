import 'package:bruder_telnet_mobile/gen/assets.gen.dart';
import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/shared/data_consumption_widget.dart';
import 'package:bruder_telnet_mobile/src/shared/elevated_tile.dart';
import 'package:bruder_telnet_mobile/src/core/theme/colors.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContractDetailScreen extends HookConsumerWidget {
  const ContractDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.42,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(Sizes.p16),
                    height: MediaQuery.of(context).size.height * 0.37,
                    color: AppColors.lightBlue,
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => context.pop(),
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: Sizes.p24,
                                  color: AppColors.white,
                                ),
                              ),
                              const Text('Übersicht')
                                  .textxlBold
                                  .foregroundColor(AppColors.white),
                              gapW24,
                            ],
                          ),
                          gapH16,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('P3400')
                                  .textmdBold
                                  .foregroundColor(AppColors.white),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text('Vertrag Nummer ID')
                                      .textxsBold
                                      .foregroundColor(AppColors.white),
                                  const Text('33120')
                                      .textmdBold
                                      .foregroundColor(AppColors.white),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const DataConsumptionUsageWidget(
                    topMargin: 187,
                    max: 30,
                    current: 3,
                    value: 0.1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Verträge').textmdBold,
                  gapH16,
                  ElevatedTile(
                    onPressed: () {},
                    leading: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Beginn').textsmRegular,
                        gapH8,
                        const Text('22 June 2024').textmdBold,
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Endent am').textsmRegular,
                        gapH8,
                        const Text('22 July 2024').textmdBold,
                      ],
                    ),
                  ),
                  gapH16,
                  ElevatedTile(
                    onPressed: () {},
                    leading: const Text('Rechnung').textxlBold,
                    trailing: const Text('Herunterladen')
                        .displayxsBold
                        .foregroundColor(AppColors.lightBlue),
                  ),
                  gapH16,
                  ElevatedTile(
                    onPressed: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tarifinformationnen')
                            .textsmBold
                            .foregroundColor(AppColors.lightBlue),
                        gapH12,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Voice und SMS Flat 4 GB Daten')
                                .textmdRegular,
                            SvgPicture.asset(
                              Assets.globe,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.brown, BlendMode.srcIn),
                            ),
                          ],
                        ),
                        gapH12,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('LTE').textmdRegular,
                            SvgPicture.asset(
                              Assets.call,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.brown, BlendMode.srcIn),
                            ),
                          ],
                        ),
                        gapH12,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('International').textmdRegular,
                            SvgPicture.asset(
                              Assets.mail,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.brown, BlendMode.srcIn),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
