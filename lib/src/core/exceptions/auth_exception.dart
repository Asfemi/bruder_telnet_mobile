/// Custom exception class for handling authentication-related errors
class AuthExceptions implements Exception {
  /// The error message to display to the user
  final String message;

  /// The original error that caused this exception (optional)
  final dynamic originalError;

  /// Error code for categorizing the error type
  final String code;

  const AuthExceptions({
    required this.message,
    required this.code,
    this.originalError,
  });

  /// Factory constructor for API-related errors
  factory AuthExceptions.fromApiError(int statusCode, [dynamic originalError]) {
    switch (statusCode) {
      case 600:
        return AuthExceptions(
          message: 'Mindestens ein Suchfeld muss ausgefüllt werden',
          code: 'INVALID_SEARCH_PARAMS',
          originalError: originalError,
        );
      case 401:
        return AuthExceptions(
          message:
              'Nicht autorisiert. Bitte überprüfen Sie Ihre Anmeldeinformationen',
          code: 'UNAUTHORIZED',
          originalError: originalError,
        );
      case 404:
        return AuthExceptions(
          message: 'Benutzer wurde nicht gefunden',
          code: 'USER_NOT_FOUND',
          originalError: originalError,
        );
      default:
        return AuthExceptions(
          message: 'Ein unerwarteter Fehler ist aufgetreten',
          code: 'UNKNOWN_ERROR',
          originalError: originalError,
        );
    }
  }

  /// Factory constructor for user-related errors
  factory AuthExceptions.userNotFound() {
    return const AuthExceptions(
      message: 'Benutzer wurde im System nicht gefunden',
      code: 'USER_NOT_FOUND',
    );
  }

  factory AuthExceptions.invalidCredentials() {
    return const AuthExceptions(
      message: 'Ungültige Anmeldeinformationen',
      code: 'INVALID_CREDENTIALS',
    );
  }

  factory AuthExceptions.weakPassword() {
    return const AuthExceptions(
      message: 'Das Passwort muss mindestens 8 Zeichen lang sein',
      code: 'WEAK_PASSWORD',
    );
  }

  factory AuthExceptions.emailAlreadyInUse() {
    return const AuthExceptions(
      message: 'Diese E-Mail-Adresse wird bereits verwendet',
      code: 'EMAIL_IN_USE',
    );
  }

  @override
  String toString() => message;
}
