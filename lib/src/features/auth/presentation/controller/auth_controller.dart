import 'package:bruder_telnet_mobile/src/features/auth/domain/repository/auth_repository.dart';
import 'package:bruder_telnet_mobile/src/features/auth/data/repository_implementation/auth_repository_impl.dart';
import 'package:bruder_telnet_mobile/src/core/exceptions/auth_exception.dart'
    as app_auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  return AuthController();
});

final authStateProvider = StreamProvider<bool>((ref) {
  return ref.watch(authControllerProvider.notifier).authStateChanges;
});

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController() : super(const AsyncData(null));

  final AuthRepository _repository = AuthRepositoryImpl();

  Stream<bool> get authStateChanges => _repository.authStateChanges;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      await _repository.signIn(
        email: email,
        password: password,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    state = const AsyncLoading();
    try {
      // Validate name format
      // if (fullName.trim().split(' ').length < 2) {
      //   throw const app_auth.AuthExceptions(
      //     message: 'Bitte geben Sie Vor- und Nachnamen ein',
      //     code: 'INVALID_NAME_FORMAT',
      //   );
      // }

      // Validate password
      if (password.length < 8) {
        throw app_auth.AuthExceptions.weakPassword();
      }

      // Validate phone format
      if (!phone.startsWith('+')) {
        throw const app_auth.AuthExceptions(
          message: 'Telefonnummer muss mit Ländervorwahl beginnen (z.B. +33)',
          code: 'INVALID_PHONE_FORMAT',
        );
      }

      await _repository.signUp(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      await _repository.signOut();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> resetPassword(String email) async {
    state = const AsyncLoading();
    try {
      await _repository.resetPassword(email);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updatePassword(String password) async {
    state = const AsyncLoading();
    try {
      // Validate password
      if (password.length < 8) {
        throw app_auth.AuthExceptions.weakPassword();
      }

      await _repository.updatePassword(password: password);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
