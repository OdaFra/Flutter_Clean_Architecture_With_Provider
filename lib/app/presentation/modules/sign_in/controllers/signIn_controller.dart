// ignore_for_file: file_names

import '../../../../core/utils/utils.dart';
import '../../../../domain/failures/sign_in_failure/sign_in_failure.dart';
import '../../../../domain/models/models.dart';
import '../../../../domain/repositories/repositories.dart';
import '../../../global/controllers/favorite/favorite_controller.dart';
import '../../../global/global.dart';
import '../../../state_notifier.dart';
import 'state/signIn_state.dart';

class SigInController extends StateNotifier<SignInState> {
  SigInController(
    super.state, {
    required this.authenticationRepository,
    required this.favoriteController,
    required this.sessionController,
  });

  final AuthenticationRepository authenticationRepository;
  final FavoriteController favoriteController;
  final SessionController sessionController;

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
      left: (_) => state = state.copyWith(
        fetching: false,
      ),
      right: (user) {
        sessionController.setUser(user);
        favoriteController.init();
      },
    );
    return result;
  }
}
