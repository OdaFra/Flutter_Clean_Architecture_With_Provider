import 'package:http/http.dart';

class AuthenticationApi {
  AuthenticationApi(this._client);
  final Client _client;

  createRequestToken() {
    _client.get(
      Uri.parse(
          'https://api.themoviedb.org/3/authentication/token/new?api_key='),
    );
  }
}
