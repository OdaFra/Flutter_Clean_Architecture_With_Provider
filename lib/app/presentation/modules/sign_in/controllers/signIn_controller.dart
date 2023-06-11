// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'signIn_state.dart';
import 'package:flutter/foundation.dart';

class SigInController extends ChangeNotifier {
  SignInState _state = const SignInState();

  SignInState get state => _state;

  bool _mounted = true;

  bool get mounted => _mounted;

  void onUsernameChanged(String text) {
    _state = _state.copyWith(
      username: text.trim().toLowerCase(),
    );
    notifyListeners();
  }

  void onPasswordChanged(String text) {
    _state = _state.copyWith(
      password: text.replaceAll(' ', ''),
    );
    notifyListeners();
  }

  void onFetchingChanged(bool value) {
    _state = _state.copyWith(fetching: value);

    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = !mounted;
    super.dispose();
  }
}
