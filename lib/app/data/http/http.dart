import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import '../../core/utils/utils.dart';

class HttpManagement {
  HttpManagement(
    this._client,
    this._baseUrl,
    this._apiKey,
  );

  final Client _client;
  final String _baseUrl;
  final String _apiKey;

  late final Response response;

  Future<Either<HttpFailure, String>> request(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
    bool useApiKey = true,
  }) async {
    try {
      if (useApiKey) {
        queryParameters = {
          ...queryParameters,
          'api_key': _apiKey,
        };
      }

      Uri url = Uri.parse(
        (path.startsWith('http') || path.startsWith('https'))
            ? path
            : '$_baseUrl$path',
      );

      if (queryParameters.isNotEmpty) {
        url = url.replace(
          queryParameters: queryParameters,
        );
      }

      headers = {
        'Content-Type': 'application/json',
        ...headers,
      };
      final String bodyString = jsonEncode(body);
      switch (method) {
        case HttpMethod.get:
          await _client.get(url);
          break;
        case HttpMethod.post:
          await _client.post(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.patch:
          await _client.patch(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.delete:
          await _client.delete(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.put:
          await _client.put(
            url,
            headers: headers,
          );
          break;
      }

      final statusCode = response.statusCode;

      if (statusCode >= 200 && statusCode < 300) {
        return Either.right(
          response.body,
        );
      }

      return Either.left(
        HttpFailure(statusCode: statusCode),
      );
    } catch (e) {
      if (e is SocketException || e is ClientException) {
        return Either.left(
          HttpFailure(
            exception: NetworKException(),
          ),
        );
      }
      return Either.left(
        HttpFailure(
          exception: e,
        ),
      );
    }
  }
}

class HttpFailure {
  HttpFailure({
    this.statusCode,
    this.exception,
  });

  final int? statusCode;
  final Object? exception;
}

class NetworKException {}

enum HttpMethod {
  get,
  post,
  patch,
  delete,
  put,
}
