import 'dart:convert';
// import 'dart:io';

// import 'package:http/http.dart';

import '../../../core/enums/enum.dart';
import '../../../core/utils/utils.dart';
import '../../http/http.dart';

class AuthenticationApi {
  AuthenticationApi(this._http);
  final HttpManagement _http;
  // final _baseUrl = 'https://api.themoviedb.org/3';
  // final _apiKey = dotenv.env['TMDB_KEY'];

  //Para obtener el token
  Future<Either<SignInFailure, String>> createRequestToken() async {
    final result = await _http.request('/authentication/token/new');

    return result.when(
      (failure) {
        if (failure.exception is NetworKException) {
          return Either.left(
            SignInFailure.network,
          );
        }
        return Either.left(
          SignInFailure.unknown,
        );
      },
      (responseBody) {
        final json = Map<String, dynamic>.from(
          jsonDecode(responseBody),
        );
        return Either.right(
          json['request_token'] as String,
        );
      },
    );

    // Codigo de ejemplo anterior para obtener el Request Token
    // try {
    //   final response = await _client.get(
    //     Uri.parse('$_baseUrl/authentication/token/new?api_key=$_apiKey'),
    //   );

    //   if (response.statusCode == 200) {
    //     final json = Map<String, dynamic>.from(
    //       jsonDecode(response.body),
    //     );
    //     // print('🔥 request_token ${json['request_token']}');
    //     return json['request_token'];
    //   }
    // } catch (e) {
    //   print('🚨 error $e');
    //   return null;
    // }
    //return null;
  }

  //Para crear sesion de login

  Future<Either<SignInFailure, String>> createSessionWithLogin(
      {required String username,
      required String password,
      required String requestToken}) async {
    final result = await _http.request(
      '/authentication/token/validate_with_login',
      method: HttpMethod.post,
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
    );

    return result.when(
      (failure) {
        if (failure.statusCode != null) {
          switch (failure.statusCode!) {
            case 401:
              return Either.left(SignInFailure.unauthorized);
            case 404:
              return Either.left(SignInFailure.notFound);
            default:
              return Either.left(SignInFailure.unknown);
          }
        }

        if (failure.exception is NetworKException) {
          return Either.left(SignInFailure.network);
        }
        return Either.left(SignInFailure.unknown);
      },
      (responseBody) {
        final json = Map<String, dynamic>.from(
          jsonDecode(responseBody),
        );
        final requestToken = json['request_token'] as String;

        return Either.right(requestToken);
      },
    );

    // try {
    //   final response = await _client.post(
    //     Uri.parse(
    //         '$_baseUrl/authentication/token/validate_with_login?api_key=$_apiKey'),
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode(
    //       {
    //         'username': username,
    //         'password': password,
    //         'request_token': requestToken,
    //       },
    //     ),
    //   );
    //   switch (response.statusCode) {
    //     case 200:
    //       final json = Map<String, dynamic>.from(
    //         jsonDecode(response.body),
    //       );
    //       final requestToken = json['request_token'] as String;

    //       return Either.right(requestToken);
    //     case 401:
    //       return Either.left(SignInFailure.unauthorized);
    //     case 404:
    //       return Either.left(SignInFailure.notFound);
    //     default:
    //       return Either.left(SignInFailure.unknown);
    //   }
    // } catch (e) {
    //   if (e is SocketException) {
    //     return Either.left(
    //       SignInFailure.network,
    //     );
    //   }
    //   return Either.left(
    //     SignInFailure.unknown,
    //   );
    // }
  }

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    final result = await _http.request(
      '/authentication/session/new',
      method: HttpMethod.post,
      body: {
        'request_token': requestToken,
      },
    );

    return result.when(
      (failure) {
        if (failure.exception is NetworKException) {
          return Either.left(
            SignInFailure.network,
          );
        }
        return Either.left(
          SignInFailure.unknown,
        );
      },
      (responseBody) {
        final json = Map<String, dynamic>.from(
          jsonDecode(responseBody),
        );
        final sessionId = json['session_id'] as String;
        return Either.right(sessionId);
      },
    );

    // try {
    //   final response = await _client.post(
    //     Uri.parse('$_baseUrl/authentication/session/new?api_key=$_apiKey'),
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode(
    //       {
    //         'request_token': requestToken,
    //       },
    //     ),
    //   );
    //   if (response.statusCode == 200) {
    //     final json = Map<String, dynamic>.from(
    //       jsonDecode(response.body),
    //     );
    //     final sessionId = json['session_id'] as String;
    //     return Either.right(sessionId);
    //   }
    //   return Either.left(SignInFailure.unknown);
    // } catch (e) {
    //   if (e is SocketException) {
    //     return Either.left(SignInFailure.network);
    //   }
    //   return Either.left(SignInFailure.unknown);
    // }
  }
}
