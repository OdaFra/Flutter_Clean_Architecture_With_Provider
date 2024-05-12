import '../../../../domain/repositories/movie_repository.dart';
import '../../../state_notifier.dart';
import 'state/movie_state.dart';

class MovieController extends StateNotifier<MovieState> {
  MovieController(
    super.state, {
    required this.movieRepository,
    required this.movieId,
  });
  final int movieId;
  final MovieRepository movieRepository;

  Future<void> init() async {
    state = MovieState.loading();

    final result = await movieRepository.getMovieById(movieId);
    state = result.when(
        left: (_) => MovieState.failed(),
        right: (movie) => MovieState.loaded(movie));
  }
}
