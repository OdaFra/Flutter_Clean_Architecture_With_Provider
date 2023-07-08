// ignore_for_file: file_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'signIn_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    required String username,
    required String password,
    required bool fetching,
  }) = _SignInState;
}
