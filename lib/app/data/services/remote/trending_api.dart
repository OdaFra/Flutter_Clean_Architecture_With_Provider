import '../../../core/enums/enum.dart';
import '../../../core/utils/utils.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/media/media.dart';
import '../../http/HttpManagement.dart';
import '../utils/handle_failure.dart';

class TrendingApi {
  final HttpManagement _http;

  TrendingApi(this._http);

  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(
      TimeWindow timeWindow) async {
    final result = await _http.request('/trending/all/${timeWindow.name}',
        onSuccess: (json) {
      final mediaList = json['result'] as List<Json>;

      return mediaList
          .where(
            (type) => type['media_type'] != 'person',
          )
          .map((e) => Media.fromJson(
                e,
              ))
          .toList();
    });
    return result.when(
      left: (httpFailure) => handleHttpFailure(httpFailure),
      right: (list) => Either.right(list),
    );
  }
}
