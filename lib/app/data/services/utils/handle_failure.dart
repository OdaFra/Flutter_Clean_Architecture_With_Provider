// Funcion para manejo de errores http failure

import '../../../core/utils/utils.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../http/failure.dart';

Either<HttpRequestFailure, R> handleHttpFailure<R>(HttpFailure httpFailure) {
  final failure = () {
    final statusCode = httpFailure.statusCode;
    switch (statusCode) {
      case 404:
        return HttpRequestFailure.notFound();
      case 401:
        return HttpRequestFailure.unauthorized();
    }
    if (httpFailure.exception is NetworKException) {
      return HttpRequestFailure.network();
    }
    return HttpRequestFailure.unknowm();
  }();
  return Either.left(failure);
}
