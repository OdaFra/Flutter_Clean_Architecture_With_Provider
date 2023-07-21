// ignore_for_file: file_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'signIn_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default('') String username,
    @Default('') String password,
    @Default(false) bool fetching,
  }) = _SignInState;
}
