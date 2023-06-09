// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'signIn_state.dart';
import 'package:flutter/foundation.dart';

class SigInController extends ChangeNotifier {
  final SignInState _state = SignInState();

  SignInState get state => _state;

  bool _mounted = true;

  bool get mounted => _mounted;

  void onUsernameChanged(String text) {
    _state.copyWith(username: text.trim().toLowerCase());
  }

  void onPasswordChanged(String text) {
    _state.copyWith(password: text.replaceAll(' ', ''));
  }

  void onFetchingChanged(bool value) {
    _state.copyWith(fetching: value);

    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = !mounted;
    super.dispose();
  }
}
