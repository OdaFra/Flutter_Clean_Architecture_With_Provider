// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../core/utils/utils.dart';
import '../../../../domain/failures/sign_in_failure.dart';
import '../../../../domain/models/models.dart';
import '../../../../domain/repositories/repositories.dart';
import '../../../state_notifier.dart';
import 'state/signIn_state.dart';

class SigInController extends StateNotifier<SignInState> {
  SigInController(
    super.state, {
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  void onUsernameChanged(String text) {
    onlyUpdate(
      state.copyWith(
        username: text.trim().toLowerCase(),
      ),
    );
  }

  void onPasswordChanged(String text) {
    onlyUpdate(
      state.copyWith(
        password: text.replaceAll(' ', ''),
      ),
    );
  }

  Future<Either<SignInFailure, User?>> submit() async {
    state = state.copyWith(fetching: true);
    final result = await authenticationRepository.signIn(
      state.username,
      state.password,
    );

    result.when(
      (_) => state = state.copyWith(fetching: false),
      (_) => null,
    );
    return result;
  }
}
