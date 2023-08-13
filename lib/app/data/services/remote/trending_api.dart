import '../../../core/enums/enum.dart';
import '../../../core/utils/utils.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/media/media.dart';
import '../../http/http.dart';
import '../utils/handle_failure.dart';

class TrendingAPI {
  final HttpManagement _httpManagement;

  TrendingAPI(this._httpManagement);

  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(
      TimeWindow timeWindow) async {
    final result = await _httpManagement
        .request('/trending/all/${timeWindow.name}', onSuccess: (json) {
      final mediaList = List.from(json['results']);

      return mediaList
          .where(
              (type) => type['media_type'] != 'person' && type['title'] != null)
          .map((e) => Media.fromJson(e))
          .toList();
    });
    return result.when(
      left: (httpFailure) => handleHttpFailure(httpFailure),
      right: (list) => Either.right(list),
    );
  }
}
