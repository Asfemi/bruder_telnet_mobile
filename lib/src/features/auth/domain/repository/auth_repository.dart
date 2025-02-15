abstract class AuthRepository {
  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  });

  Future<void> signOut();

  Future<void> resetPassword(String email);

  Future<bool> checkUserExistsInExternalApi(String email);

  Future<void> updatePassword({
    required String password,
  });

  Stream<bool> get authStateChanges;
}
