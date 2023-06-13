// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  User({
    required this.id,
    required this.username,
  });

  final int id;
  final String username;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
