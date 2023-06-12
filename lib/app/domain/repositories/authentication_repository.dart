import '../../core/enums/enum.dart';
import '../../core/utils/utils.dart';
import '../models/models.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<void> signOut();
  Future<Either<SignInFailure, User>> signIn(String username, String password);
}
