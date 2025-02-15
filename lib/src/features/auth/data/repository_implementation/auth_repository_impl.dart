import 'package:bruder_telnet_mobile/src/config/supabase_config.dart';
import 'package:bruder_telnet_mobile/src/features/auth/data/data_source/remote_datesource.dart';
import 'package:bruder_telnet_mobile/src/core/exceptions/auth_exception.dart'
    as app_auth;
import 'package:bruder_telnet_mobile/src/features/auth/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'dart:developer' as dev;

/// Implementation of the [AuthRepository] interface that handles authentication
/// using Supabase and an external API for customer validation.
///
/// This implementation follows a two-step authentication process:
/// 1. Validates the user exists in the external customer database
/// 2. Handles authentication state using Supabase
class AuthRepositoryImpl implements AuthRepository {
  /// Supabase client instance for authentication
  final SupabaseClient _supabase;

  /// API service instance for external API calls
  final RemoteDataSource _apiService;

  AuthRepositoryImpl({
    SupabaseClient? supabaseClient,
    RemoteDataSource? remoteDataSource,
  })  : _supabase = supabaseClient ?? SupabaseConfig.client,
        _apiService = remoteDataSource ?? RemoteDataSource();

  final _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['NEXT_PUBLIC_API_URL']!,
    headers: {
      'Content-Type': 'application/json',
      "API-Token": dotenv.env['API_TOKEN']!,
    },
  ));

  /// Stream of authentication state changes
  /// Returns true if user is authenticated, false otherwise
  @override
  Stream<bool> get authStateChanges =>
      _supabase.auth.onAuthStateChange.map((event) => event.session != null);

  /// Signs in a user with email and password
  ///
  /// The sign-in process follows these steps:
  /// 1. Checks if the user exists in the external API
  /// 2. If user exists, attempts to sign in with Supabase
  /// 3. If successful, the user is authenticated
  ///
  /// Throws [AuthException] if:
  /// - User not found in external system
  /// - Invalid credentials
  /// - Network or server errors
  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      dev.log('Attempting sign in for email: $email', name: 'AuthRepository');

      // Step 1: Validate user exists in external system
      final customers = await _apiService.searchCustomers(email: email);

      if (customers.isEmpty) {
        dev.log('User not found in external system', name: 'AuthRepository');
        throw app_auth.AuthExceptions.userNotFound();
      }

      // Step 2: Authenticate with Supabase
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      dev.log('Sign in successful', name: 'AuthRepository');
    } on app_auth.AuthExceptions {
      rethrow;
    } on DioException catch (e) {
      dev.log('API error during sign in: ${e.toString()}',
          name: 'AuthRepository', error: e);
      throw app_auth.AuthExceptions.fromApiError(
        e.response?.statusCode ?? 500,
        e,
      );
    } catch (e) {
      dev.log('Unexpected error during sign in: ${e.toString()}',
          name: 'AuthRepository', error: e);
      throw app_auth.AuthExceptions(
        message: 'Ein unerwarteter Fehler ist aufgetreten',
        code: 'UNKNOWN_ERROR',
        originalError: e,
      );
    }
  }

  /// Registers a new user with the provided information
  ///
  /// The registration process follows these steps:
  /// 1. Validates the full name format (must have first and last name)
  /// 2. Checks if user exists in external API using name and email
  /// 3. Creates a new Supabase account with user data
  ///
  /// Important: Users can only register if they exist in the external system
  /// This ensures only valid customers can create accounts
  ///
  /// Throws [AuthException] if:
  /// - Invalid name format
  /// - User not found in external system
  /// - Account creation fails
  /// - Network or server errors
  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      dev.log('Attempting sign up for email: $email', name: 'AuthRepository');

      // Step 1: Validate name format
      final nameParts = fullName.trim().split(' ');
      if (nameParts.length < 2) {
        throw const app_auth.AuthExceptions(
          message: 'Bitte geben Sie Vor- und Nachnamen ein',
          code: 'INVALID_NAME_FORMAT',
        );
      }

      // Step 2: Check if user exists in external system
      final customers = await _apiService.searchCustomers(
        firstName: nameParts.first,
        lastName: nameParts.sublist(1).join(' '),
        email: email,
      );

      if (customers.isEmpty) {
        dev.log('User not found in external system', name: 'AuthRepository');
        throw const app_auth.AuthExceptions(
          message:
              'Benutzer wurde im System nicht gefunden. Bitte wenden Sie sich an den Administrator.',
          code: 'USER_NOT_FOUND',
        );
      }

      // Step 3: Create Supabase account with customer data
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone': phone,
          'customer_data':
              customers.first, // Store customer data for future use
        },
      );

      if (response.user == null) {
        throw const app_auth.AuthExceptions(
          message: 'Konto konnte nicht erstellt werden',
          code: 'ACCOUNT_CREATION_FAILED',
        );
      }

      dev.log('Sign up successful', name: 'AuthRepository');
    } on app_auth.AuthExceptions {
      rethrow;
    } on DioException catch (e) {
      dev.log('API error during sign up: ${e.toString()}',
          name: 'AuthRepository', error: e);
      throw app_auth.AuthExceptions.fromApiError(
        e.response?.statusCode ?? 500,
        e,
      );
    } catch (e) {
      dev.log('Unexpected error during sign up: ${e.toString()}',
          name: 'AuthRepository', error: e);
      throw app_auth.AuthExceptions(
        message: 'Ein unerwarteter Fehler ist aufgetreten',
        code: 'UNKNOWN_ERROR',
        originalError: e,
      );
    }
  }

  /// Signs out the currently authenticated user
  ///
  /// This will:
  /// 1. Clear the Supabase session
  /// 2. Trigger authStateChanges to emit false
  @override
  Future<void> signOut() async {
    try {
      dev.log('Attempting sign out', name: 'AuthRepository');
      await _supabase.auth.signOut();
      dev.log('Sign out successful', name: 'AuthRepository');
    } catch (e) {
      dev.log('Error during sign out: ${e.toString()}',
          name: 'AuthRepository', error: e);
      throw app_auth.AuthExceptions(
        message: 'Abmeldung fehlgeschlagen',
        code: 'SIGN_OUT_FAILED',
        originalError: e,
      );
    }
  }

  /// Initiates the password reset process for the given email
  ///
  /// The process follows these steps:
  /// 1. Validates the user exists in the external system
  /// 2. Sends a password reset email through Supabase
  ///
  /// Throws [AuthException] if:
  /// - User not found in external system
  /// - Email sending fails
  @override
  Future<void> resetPassword(String email) async {
    try {
      dev.log('Attempting password reset for email: $email',
          name: 'AuthRepository');

      // Step 1: Validate user exists
      final customers = await _apiService.searchCustomers(email: email);

      if (customers.isEmpty) {
        throw app_auth.AuthExceptions.userNotFound();
      }

      // Step 2: Send reset email
      await _supabase.auth.resetPasswordForEmail(email);
      dev.log('Password reset email sent', name: 'AuthRepository');
    } on app_auth.AuthExceptions {
      rethrow;
    } catch (e) {
      dev.log('Error during password reset: ${e.toString()}',
          name: 'AuthRepository', error: e);
      throw app_auth.AuthExceptions(
        message: 'Passwort zurücksetzen fehlgeschlagen',
        code: 'PASSWORD_RESET_FAILED',
        originalError: e,
      );
    }
  }

  /// Updates the password for the currently authenticated user
  ///
  /// Validates that:
  /// 1. Password meets minimum length requirement (8 characters)
  /// 2. User is authenticated
  @override
  Future<void> updatePassword({required String password}) async {
    try {
      dev.log('Attempting password update', name: 'AuthRepository');

      if (password.length < 8) {
        throw app_auth.AuthExceptions.weakPassword();
      }

      await _supabase.auth.updateUser(
        UserAttributes(password: password),
      );

      dev.log('Password updated successfully', name: 'AuthRepository');
    } catch (e) {
      dev.log('Error during password update: ${e.toString()}',
          name: 'AuthRepository', error: e);
      throw app_auth.AuthExceptions(
        message: 'Passwort konnte nicht aktualisiert werden',
        code: 'PASSWORD_UPDATE_FAILED',
        originalError: e,
      );
    }
  }

  @override
  Future<bool> checkUserExistsInExternalApi(String email,
      {String? fullName}) async {
    dev.log('Starting user existence check in external API',
        name: 'AuthRepository');
    dev.log(
        'Checking for email: $email${fullName != null ? ' and name: $fullName' : ''}',
        name: 'AuthRepository');

    try {
      // Split full name into first and last name if provided
      String? firstName;
      String? lastName;

      if (fullName != null) {
        final nameParts = fullName.trim().split(' ');
        if (nameParts.length >= 2) {
          firstName = nameParts.first;
          lastName = nameParts.sublist(1).join(' ');
          dev.log('Name split into: firstName=$firstName, lastName=$lastName',
              name: 'AuthRepository');
        } else {
          dev.log(
              'Warning: Full name provided but could not be split properly: $fullName',
              name: 'AuthRepository');
        }
      }

      final requestData = {
        "customer_number": null,
        "firstname": firstName,
        "lastname": lastName,
        "companyname": null,
        "street": null,
        "housenumber": null,
        "postal_code": null,
        "city": null,
        "external_customer_number": null
      };

      dev.log('Making API request with data: $requestData',
          name: 'AuthRepository');

      final response = await _dio.post(
        '/get_customers',
        data: requestData,
      );

      dev.log('API response received: status=${response.data['status']}',
          name: 'AuthRepository');

      // Check for error code 600
      if (response.data['status'] == 600) {
        dev.log('Error 600: No search fields set', name: 'AuthRepository');
        throw 'Mindestens ein Suchfeld muss ausgefüllt werden';
      }

      if (response.data['status'] != 1) {
        dev.log('API request failed with status: ${response.data['status']}',
            name: 'AuthRepository');
        throw 'API-Anfrage fehlgeschlagen';
      }

      final customers = response.data['data'] as List;
      dev.log('Retrieved ${customers.length} customers from API',
          name: 'AuthRepository');

      final userExists =
          customers.any((customer) => customer['email'] == email);
      dev.log('User ${userExists ? 'found' : 'not found'} with email: $email',
          name: 'AuthRepository');

      return userExists;
    } catch (e) {
      dev.log('Error during API check: ${e.toString()}',
          name: 'AuthRepository', error: e);
      if (e is String) {
        throw Exception(e);
      }
      throw Exception(
          'Fehler bei der Überprüfung des Benutzers im externen System: ${e.toString()}');
    }
  }
}
