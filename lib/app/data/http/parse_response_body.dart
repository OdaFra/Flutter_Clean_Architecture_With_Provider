import 'dart:convert';

dynamic parseResponseBody(dynamic responseBody) {
  try {
    return jsonDecode(responseBody);
  } catch (_) {
    return responseBody;
  }
}
