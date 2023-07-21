import '../../core/utils/either.dart';
import '../../domain/failures/sign_in_failure.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';
import '../services/local/session_service.dart';
import '../services/remote/account_api.dart';
import '../services/remote/authentication_api.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
    this._authenticationApi,
    this._sessionService,
    this._accountApi,
  );
  final AuthenticationApi _authenticationApi;
  final SessionService _sessionService;
  final AccountApi _accountApi;

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _sessionService.sessionId;
    return sessionId != null;
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
  ) async {
    final requestTokenResult = await _authenticationApi.createRequestToken();
    return requestTokenResult.when(
      (failure) => Either.left(failure),
      (requestToken) async {
        final loginResult = await _authenticationApi.createSessionWithLogin(
          username: username,
          password: password,
          requestToken: requestToken,
        );

        return loginResult.when(
          (failure) async => Either.left(failure),
          (newRequestToken) async {
            final sessionResult = await _authenticationApi.createSession(
              newRequestToken,
            );
            return sessionResult.when(
              (failure) async => Either.left(failure),
              (sessionId) async {
                await _sessionService.saveSessionId(sessionId);
                final user = await _accountApi.getAccount(sessionId);
                if (user == null) {
                  return Either.left(
                    Unkonwn(),
                  );
                }
                return Either.right(
                  user,
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Future<void> signOut() {
    return _sessionService.signOut();
  }
}
