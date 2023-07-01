import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.avatarPath,
  });

  final int id;
  final String username;
  @JsonKey(name: 'avatar', fromJson: avatarPathFromJson)
  final String? avatarPath;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  List<Object?> get props => [
        id,
        username,
      ];
}

String? avatarPathFromJson(Map<String, dynamic> json) {
  json['tmdb']?['avatar_path'] as String?;
  return null;
}
