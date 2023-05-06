import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../../../core/enums/enum.dart';
import '../../../core/utils/utils.dart';

class AuthenticationApi {
  AuthenticationApi(this._client);
  final Client _client;
  final _baseUrl = 'https://api.themoviedb.org/3';
  final _apiKey = dotenv.env['TMDB_KEY'];

  //Para obtener el token
  Future<String?> createRequestToken() async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/authentication/token/new?api_key=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final json = Map<String, dynamic>.from(
          jsonDecode(response.body),
        );
        // print('🔥 request_token ${json['request_token']}');
        return json['request_token'];
      }
    } catch (e) {
      print('🚨 error $e');
      return null;
    }
    return null;
  }

  //Para crear sesion de login

  Future<Either<SignInFailure, String>> createSessionWithLogin(
      {required String username,
      required String password,
      required String requestToken}) async {
    try {
      final response = await _client.post(
        Uri.parse(
            '$_baseUrl/authentication/token/validate_with_login?api_key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'username': username,
            'password': password,
            'request_token': requestToken,
          },
        ),
      );
      switch (response.statusCode) {
        case 200:
          final json = Map<String, dynamic>.from(
            jsonDecode(response.body),
          );
          final requestToken = json['request_token'] as String;

          return Either.right(requestToken);
        case 401:
          return Either.left(SignInFailure.unauthorized);
        case 404:
          return Either.left(SignInFailure.notFound);
        default:
          return Either.left(SignInFailure.unknown);
      }
    } catch (e) {
      if (e is SocketException) {
        return Either.left(
          SignInFailure.network,
        );
      }
      return Either.left(
        SignInFailure.unknown,
      );
    }
  }

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/authentication/session/new?api_key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'request_token': requestToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        final json = Map<String, dynamic>.from(
          jsonDecode(response.body),
        );
        final sessionId = json['session_id'] as String;
        return Either.right(sessionId);
      }
      return Either.left(SignInFailure.unknown);
    } catch (e) {
      if (e is SocketException) {
        return Either.left(SignInFailure.network);
      }
      return Either.left(SignInFailure.unknown);
    }
  }
}
