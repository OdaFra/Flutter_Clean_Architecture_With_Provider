// ignore_for_file: public_member_api_docs, sort_constructors_first, invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String username,

    ///
    @JsonKey(
      name: 'avatar',
      fromJson: avatarPathFromJson,
    )
    String? avatarPath,
  }) = _User;
  const User._();

  String getFormatted() {
    return '$username $id';
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

String? avatarPathFromJson(Map<String, dynamic> json) {
  return json['tmdb']?['avatar_path'] as String?;
}
