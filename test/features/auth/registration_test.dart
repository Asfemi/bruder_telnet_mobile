import 'package:bruder_telnet_mobile/src/features/auth/data/repository_implementation/auth_repository_impl.dart';
import 'package:bruder_telnet_mobile/src/features/auth/domain/repository/auth_repository.dart';
import 'package:bruder_telnet_mobile/src/core/exceptions/auth_exception.dart'
    as app_auth;
import 'package:bruder_telnet_mobile/src/features/auth/data/data_source/remote_datesource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Mock classes
class MockAuthRepository extends Mock implements AuthRepository {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  late AuthRepository authRepository;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;
  late MockRemoteDataSource mockRemoteDataSource;

  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();
    mockRemoteDataSource = MockRemoteDataSource();

    // Setup mock behavior
    when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);

    // Inject mocked client into repository
    authRepository = AuthRepositoryImpl(
      supabaseClient: mockSupabaseClient,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('Registration Tests', () {
    final validEmail = 'test@example.com';
    final validPassword = 'password123';
    final validFullName = 'John Doe';
    final validPhone = '+33123456789';

    final mockCustomerData = {
      'customer_number': 12345,
      'firstname': 'John',
      'lastname': 'Doe',
      'email': 'test@example.com',
    };

    test('successful registration with valid data', () async {
      // Arrange
      when(() => mockRemoteDataSource.searchCustomers(
            email: validEmail,
            firstName: 'John',
            lastName: 'Doe',
          )).thenAnswer((_) async => [mockCustomerData]);

      when(() => mockGoTrueClient.signUp(
            email: validEmail,
            password: validPassword,
            data: any(named: 'data'),
          )).thenAnswer((_) async => AuthResponse(
            user: User(
              id: '123',
              email: validEmail,
              createdAt: DateTime.now().toString(),
              appMetadata: {},
              userMetadata: {},
              aud: 'authenticated',
            ),
          ));

      // Act & Assert
      await expectLater(
        authRepository.signUp(
          email: validEmail,
          password: validPassword,
          fullName: validFullName,
          phone: validPhone,
        ),
        completes,
      );
    });

    test('registration fails when user not found in external system', () async {
      // Arrange
      when(() => mockRemoteDataSource.searchCustomers(
            email: validEmail,
            firstName: 'John',
            lastName: 'Doe',
          )).thenAnswer((_) async => []);

      // Act & Assert
      await expectLater(
        authRepository.signUp(
          email: validEmail,
          password: validPassword,
          fullName: validFullName,
          phone: validPhone,
        ),
        throwsA(isA<app_auth.AuthExceptions>().having(
          (e) => e.code,
          'code',
          'USER_NOT_FOUND',
        )),
      );
    });

    test('registration fails with invalid name format', () async {
      // Act & Assert
      await expectLater(
        authRepository.signUp(
          email: validEmail,
          password: validPassword,
          fullName: 'John', // Missing last name
          phone: validPhone,
        ),
        throwsA(isA<app_auth.AuthExceptions>().having(
          (e) => e.code,
          'code',
          'INVALID_NAME_FORMAT',
        )),
      );
    });

    test('registration fails with weak password', () async {
      // Act & Assert
      await expectLater(
        authRepository.signUp(
          email: validEmail,
          password: '123', // Too short
          fullName: validFullName,
          phone: validPhone,
        ),
        throwsA(isA<app_auth.AuthExceptions>().having(
          (e) => e.code,
          'code',
          'WEAK_PASSWORD',
        )),
      );
    });

    test('registration fails with invalid phone format', () async {
      // Act & Assert
      await expectLater(
        authRepository.signUp(
          email: validEmail,
          password: validPassword,
          fullName: validFullName,
          phone: '123456789', // Missing country code
        ),
        throwsA(isA<app_auth.AuthExceptions>().having(
          (e) => e.code,
          'code',
          'INVALID_PHONE_FORMAT',
        )),
      );
    });

    test('registration fails with network error', () async {
      // Arrange
      when(() => mockRemoteDataSource.searchCustomers(
            email: validEmail,
            firstName: 'John',
            lastName: 'Doe',
          )).thenThrow(Exception('Network error'));

      // Act & Assert
      await expectLater(
        authRepository.signUp(
          email: validEmail,
          password: validPassword,
          fullName: validFullName,
          phone: validPhone,
        ),
        throwsA(isA<app_auth.AuthExceptions>().having(
          (e) => e.code,
          'code',
          'UNKNOWN_ERROR',
        )),
      );
    });

    test('registration stores customer data in user metadata', () async {
      // Arrange
      when(() => mockRemoteDataSource.searchCustomers(
            email: validEmail,
            firstName: 'John',
            lastName: 'Doe',
          )).thenAnswer((_) async => [mockCustomerData]);

      var capturedData;
      when(() => mockGoTrueClient.signUp(
            email: validEmail,
            password: validPassword,
            data: any(named: 'data'),
          )).thenAnswer((invocation) {
        capturedData = invocation.namedArguments[#data];
        return Future.value(AuthResponse(
          user: User(
            id: '123',
            email: validEmail,
            createdAt: DateTime.now().toString(),
            appMetadata: {},
            userMetadata: {},
            aud: 'authenticated',
          ),
        ));
      });

      // Act
      await authRepository.signUp(
        email: validEmail,
        password: validPassword,
        fullName: validFullName,
        phone: validPhone,
      );

      // Assert
      expect(capturedData['customer_data'], equals(mockCustomerData));
      expect(capturedData['full_name'], equals(validFullName));
      expect(capturedData['phone'], equals(validPhone));
    });
  });
}
