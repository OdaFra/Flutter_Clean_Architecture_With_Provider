part of 'HttpManagement.dart';

dynamic _parseResponseBody(String responseBody) {
  try {
    return jsonDecode(responseBody);
  } catch (_) {
    return responseBody;
  }
}
