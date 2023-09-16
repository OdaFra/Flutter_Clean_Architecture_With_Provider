import '../../core/enums/timeWindows.dart';
import '../../core/utils/either.dart';
import '../../domain/failures/http_request/http_request_failure.dart';
import '../../domain/models/media/media.dart';
import '../../domain/models/peformer/performer.dart';
import '../../domain/repositories/repositories.dart';
import '../services/remote/trending_api.dart';

class TrendingRepositoryImpl implements TrendingRepository {
  final TrendingAPI _trendingAPI;

  TrendingRepositoryImpl(this._trendingAPI);
  @override
  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(
    TimeWindow timeWindow,
  ) {
    return _trendingAPI.getMoviesAndSeries(timeWindow);
  }

  @override
  Future<Either<HttpRequestFailure, List<Performer>>> getPerformers() {
    return _trendingAPI.getPerformers(TimeWindow.day);
  }
}
