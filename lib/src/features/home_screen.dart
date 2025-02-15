import 'package:bruder_telnet_mobile/gen/assets.gen.dart';
import 'package:bruder_telnet_mobile/src/core/router/app_router.dart';
import 'package:bruder_telnet_mobile/src/shared/navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({
    super.key,
    required this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final currentRoute =
        router.routeInformationProvider.value.uri.pathSegments.last;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationBarItem(
            onTap: () => context.goNamed(AppRoutes.contracts.name),
            assetUrl: Assets.homeIcon,
            label: 'Home',
            isSelected: currentRoute == AppRoutes.contracts.name,
          ),
          NavigationBarItem(
            onTap: () => context.goNamed(AppRoutes.invoiceAvailableSoon.name),
            assetUrl: Assets.invoiceIcon,
            label: 'Rechnungen',
            isSelected: currentRoute == 'invoice-available-soon',
          ),
          NavigationBarItem(
            onTap: () => context.goNamed(AppRoutes.account.name),
            assetUrl: Assets.profileIcon,
            label: 'Account',
            isSelected: currentRoute == AppRoutes.account.name,
          ),
        ],
      ),
    );
  }
}
