// ignore_for_file: file_names

import '../../../../core/utils/utils.dart';
import '../../../../domain/failures/sign_in_failure/sign_in_failure.dart';
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
      left: (_) => state = state.copyWith(fetching: false),
      right: (_) => null,
    );
    return result;
  }
}
