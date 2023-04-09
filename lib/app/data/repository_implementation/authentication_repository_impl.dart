import '../../domain/models/user.dart';
import '../../domain/repositories/repositories.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<User?> getUserData() {
    return Future.value(
      User(),
    );
  }

  @override
  Future<bool> get isSignedIn {
    return Future.value(true);
  }
}
