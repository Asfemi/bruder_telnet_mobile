import 'package:bruder_telnet_mobile/src/features/account/presentation/account_screen.dart';
import 'package:bruder_telnet_mobile/src/features/account/presentation/update_profile_screen.dart';
import 'package:bruder_telnet_mobile/src/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:bruder_telnet_mobile/src/features/auth/presentation/pages/login_screen.dart';
import 'package:bruder_telnet_mobile/src/features/auth/presentation/pages/register_screen.dart';
import 'package:bruder_telnet_mobile/src/features/contract/presentation/contract_detail_screen.dart';
import 'package:bruder_telnet_mobile/src/features/contract/presentation/contracts_screen.dart';
import 'package:bruder_telnet_mobile/src/features/faq/presentation/faq_screen.dart';
import 'package:bruder_telnet_mobile/src/features/home_screen.dart';
import 'package:bruder_telnet_mobile/src/features/invoice/presentation/invoice_available_soon_screen.dart';
import 'package:flutter/material.dart';
// import 'package:bruder_telnet_mobile/src/features/invoice/presentation/invoice_detail_screen.dart';
// import 'package:bruder_telnet_mobile/src/features/invoice/presentation/invoice_filter_result_screen.dart';
// import 'package:bruder_telnet_mobile/src/features/invoice/presentation/invoices_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AppRoutes {
  login,
  register,
  forgotPassword,
  contracts,
  contractDetail,
  invoices,
  invoiceAvailableSoon,
  invoiceFilterResult,
  invoiceDetail,
  account,
  updateProfile,
  faq,
}

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          name: AppRoutes.login.name,
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: 'register',
              name: AppRoutes.register.name,
              builder: (context, state) => const RegisterScreen(),
            ),
            GoRoute(
              path: 'forgot-password',
              name: AppRoutes.forgotPassword.name,
              builder: (context, state) => const ForgotPasswordScreen(),
            ),
          ],
        ),
        ShellRoute(
          builder: (context, state, child) => HomeScreen(child: child),
          routes: [
            GoRoute(
              path: '/contracts',
              name: AppRoutes.contracts.name,
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const ContractsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
              routes: [
                GoRoute(
                  path: ':contractId',
                  name: AppRoutes.contractDetail.name,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    child: const ContractDetailScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                )
              ],
            ),
            // GoRoute(
            //   path: '/invoices',
            //   name: AppRoutes.invoices.name,
            //   builder: (context, state) => const InvoicesScreen(),
            //   routes: [
            //     GoRoute(
            //       path: ':invoiceId',
            //       name: AppRoutes.invoiceDetail.name,
            //       builder: (context, state) => const InvoiceDetailScreen(),
            //     ),
            //     GoRoute(
            //       path: 'filter-result/:filterFromDate/:filterToDate',
            //       name: AppRoutes.invoiceFilterResult.name,
            //       builder: (context, state) {
            //         final parameters = state.pathParameters;
            //         final filterFromDate =
            //             parameters['filterFromDate'] as String;
            //         final filterToDate = parameters['filterToDate'] as String;
            //         return InvoiceFilterResultScreen(
            //           filterFromDate: filterFromDate,
            //           filterToDate: filterToDate,
            //         );
            //       },
            //     ),
            //   ],
            // ),
            GoRoute(
              path: '/invoice-available-soon',
              name: AppRoutes.invoiceAvailableSoon.name,
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const InvoiceAvailableSoonScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            ),
            GoRoute(
              path: '/account',
              name: AppRoutes.account.name,
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const AccountScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
              routes: [
                GoRoute(
                  path: 'update-profile',
                  name: AppRoutes.updateProfile.name,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    child: const UpdateProfileScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/faq',
          name: AppRoutes.faq.name,
          builder: (context, state) => const FaqScreen(),
        ),
      ],
    );
  },
);
