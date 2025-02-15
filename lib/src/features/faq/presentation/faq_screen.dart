import 'package:bruder_telnet_mobile/src/core/constants/app_constants.dart';
import 'package:bruder_telnet_mobile/src/core/constants/app_sizes.dart';
import 'package:bruder_telnet_mobile/src/features/faq/presentation/primary_expanded_tile.dart';
import 'package:bruder_telnet_mobile/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FaqScreen extends HookConsumerWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faqList = AppConstants.mockFaqs;
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs').textxlBold,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final faq = faqList[index];
          return PrimaryExpandedTile(
            title: faq.question,
            content: faq.answer,
          );
        },
        separatorBuilder: (_, __) => gapH16,
        itemCount: faqList.length,
      ).paddingOnly(
        left: Sizes.p16,
        right: Sizes.p16,
        bottom: Sizes.p16,
      ),
    );
  }
}
