
import '../../core/utils/utils.dart';
import '../failures/sign_in_failure/sign_in_failure.dart';
import '../models/models.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<void> signOut();
  Future<Either<SignInFailure, User>> signIn(String username, String password);
}
