import '../../core/utils/either.dart';
import '../../domain/failures/http_request/http_request_failure.dart';
import '../../domain/models/movies/movies.dart';
import '../../domain/models/peformer/performer.dart';
import '../../domain/repositories/repositories.dart';
import '../services/remote/movie_api.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApi _movieApi;

  MovieRepositoryImpl(this._movieApi);
  @override
  Future<Either<HttpRequestFailure, Movie>> getMovieById(int id) {
    return _movieApi.getMovieById(id);
  }

  @override
  Future<Either<HttpRequestFailure, List<Performer>>> getCatsByMovie(
      int movieId) {
    return _movieApi.getCatsByMovie(movieId);
  }
}
