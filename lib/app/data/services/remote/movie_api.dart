import '../../../core/utils/utils.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/movies/movies.dart';
import '../../http/http.dart';
import '../utils/handle_failure.dart';

class MovieApi {
  final HttpManagement _http;

  MovieApi(this._http);

  Future<Either<HttpRequestFailure, Movie>> getMovieById(int id) async {
    final result = await _http.request('/movie/$id', onSuccess: (json) {
      return Movie.fromJson(json);
    });

    return result.when(
      left: handleHttpFailure,
      right: (movie) => Either.right(movie),
    );
  }
}
