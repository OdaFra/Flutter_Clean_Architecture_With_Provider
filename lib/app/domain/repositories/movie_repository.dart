import '../../core/utils/utils.dart';
import '../failures/http_request/http_request_failure.dart';
import '../models/movies/movies.dart';
import '../models/peformer/performer.dart';

abstract class MovieRepository {
  Future<Either<HttpRequestFailure, Movie>> getMovieById(int id);
  Future<Either<HttpRequestFailure, List<Performer>>> getCatsByMovie(
      int movieId);
}
