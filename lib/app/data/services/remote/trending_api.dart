import '../../../core/enums/enums.dart';
import '../../../core/utils/utils.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/media/media.dart';
import '../../../domain/models/peformer/performer.dart';
import '../../http/http.dart';
import '../utils/handle_failure.dart';

class TrendingAPI {
  final HttpManagement _httpManagement;

  TrendingAPI(this._httpManagement);

  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(
      TimeWindow timeWindow) async {
    final result = await _httpManagement
        .request('/trending/all/${timeWindow.name}', onSuccess: (json) {
      final list = List<Json>.from(json['results']);

      return getMediaList(list);
      // list
      //     .where(
      //       (type) =>
      //           type['media_type'] != 'person' &&
      //           type['title'] != null &&
      //           type['poster_path'] != null &&
      //           type['backdrop_path'] != null,
      //     )
      //     .map((e) => Media.fromJson(e))
      //     .toList();
    });
    return result.when(
      left: (httpFailure) => handleHttpFailure(httpFailure),
      right: (list) => Either.right(list),
    );
  }

  Future<Either<HttpRequestFailure, List<Performer>>> getPerformers(
      TimeWindow timeWindow) async {
    final result = await _httpManagement
        .request('/trending/person/${timeWindow.name}', onSuccess: (json) {
      final list = List<Json>.from(json['results']);

      return list
          .where(
            (e) =>
                e['known_for_department'] == 'Acting' &&
                e['profile_path'] != null,
          )
          .map((e) => Performer.fromJson(e))
          .toList();
    });
    return result.when(
      left: (httpFailure) => handleHttpFailure(httpFailure),
      right: (list) => Either.right(list),
    );
  }
}
