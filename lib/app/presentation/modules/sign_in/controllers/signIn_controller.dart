// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../state_notifier.dart';
import 'signIn_state.dart';

class SigInController extends StateNotifier<SignInState> {
  SigInController(super.state);

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

  void onFetchingChanged(bool value) {
    state = state.copyWith(fetching: value);
  }
}
