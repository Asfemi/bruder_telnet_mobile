import 'package:bruder_telnet_mobile/src/features/auth/data/repository_implementation/auth_repository_impl.dart';
import 'package:bruder_telnet_mobile/src/features/auth/domain/repository/auth_repository.dart';
import 'package:bruder_telnet_mobile/src/core/exceptions/auth_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Mock classes
class MockAuthRepository extends Mock implements AuthRepository {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

void main() {
  late AuthRepository authRepository;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;

  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();

    // Setup mock behavior
    when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);

    // Inject mocked client into repository
    authRepository = AuthRepositoryImpl(
      supabaseClient: mockSupabaseClient,
    );
  });

  tearDownAll(() async {
    await Supabase.instance.client.dispose();
  });

  group('Login Tests', () {
    final validEmail = 'test@example.com';
    final validPassword = 'password123';
    final invalidEmail = 'invalid@example.com';
    final invalidPassword = 'wrong';

    test('successful login with valid credentials', () async {
      // Arrange
      when(() => mockGoTrueClient.signInWithPassword(
            email: validEmail,
            password: validPassword,
          )).thenAnswer((_) async => AuthResponse());

      // Act & Assert
      expect(
        () => authRepository.signIn(
          email: validEmail,
          password: validPassword,
        ),
        completes,
      );
    });

    test('login fails with non-existent user', () async {
      // Arrange
      when(() => mockGoTrueClient.signInWithPassword(
            email: invalidEmail,
            password: validPassword,
          )).thenThrow(AuthExceptions.userNotFound());

      // Act & Assert
      expect(
        () => authRepository.signIn(
          email: invalidEmail,
          password: validPassword,
        ),
        throwsA(isA<AuthExceptions>()),
      );
    });

    test('login fails with wrong password', () async {
      // Arrange
      when(() => mockGoTrueClient.signInWithPassword(
            email: validEmail,
            password: invalidPassword,
          )).thenThrow(AuthExceptions.invalidCredentials());

      // Act & Assert
      expect(
        () => authRepository.signIn(
          email: validEmail,
          password: invalidPassword,
        ),
        throwsA(isA<AuthExceptions>()),
      );
    });

    test('login fails with empty email', () async {
      // Act & Assert
      expect(
        () => authRepository.signIn(
          email: '',
          password: validPassword,
        ),
        throwsA(isA<AuthExceptions>()),
      );
    });

    test('login fails with empty password', () async {
      // Act & Assert
      expect(
        () => authRepository.signIn(
          email: validEmail,
          password: '',
        ),
        throwsA(isA<AuthExceptions>()),
      );
    });

    test('login fails with network error', () async {
      // Arrange
      when(() => mockGoTrueClient.signInWithPassword(
            email: validEmail,
            password: validPassword,
          )).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
        () => authRepository.signIn(
          email: validEmail,
          password: validPassword,
        ),
        throwsA(isA<AuthExceptions>()),
      );
    });

    test('login maintains session after successful authentication', () async {
      // Arrange
      final mockSession = Session(
        accessToken: 'mock_token',
        tokenType: 'bearer',
        user: User(
          id: '123',
          email: validEmail,
          createdAt: DateTime.now().toString(),
          appMetadata: {},
          userMetadata: {},
          aud: 'authenticated',
        ),
      );

      when(() => mockGoTrueClient.signInWithPassword(
            email: validEmail,
            password: validPassword,
          )).thenAnswer((_) async => AuthResponse(session: mockSession));

      // Act
      await authRepository.signIn(
        email: validEmail,
        password: validPassword,
      );

      // Assert
      verify(() => mockGoTrueClient.currentSession).called(1);
    });
  });
}
