import '../../../../core/utils/utils.dart';

import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/repositories.dart';
import '../../../state_notifier.dart';
import 'favorite_state.dart';

class FavoriteController extends StateNotifier<FavoriteState> {
  FavoriteController(
    super.state, {
    required this.accountRepository,
  });

  final AccountRepository accountRepository;

  Future<void> init() async {
    state = FavoriteState.loading();

    final moviesResult = await accountRepository.getFavorites(MediaType.movie);

    state = await moviesResult.when(
      left: (_) async => state = FavoriteState.failed(),
      right: (movies) async {
        final seriesResult = await accountRepository.getFavorites(MediaType.tv);

        return seriesResult.when(
          left: (_) => state = FavoriteState.failed(),
          right: (series) => FavoriteState.loaded(
            movies: movies,
            series: series,
          ),
        );
      },
    );
  }

  Future<Either<HttpRequestFailure, void>> markAsFavorite(Media media) async {
    assert(state is FavoriteStateLoaded);
    final loadedState = state as FavoriteStateLoaded;
    final isMovie = media.type == MediaType.movie;
    final map = isMovie ? {...loadedState.movies} : {...loadedState.series};
    final favorite = !map.keys.contains(media.id);
    final result = await accountRepository.markAsFavorite(
      mediaId: media.id,
      type: media.type,
      favorite: favorite,
    ); result.whenOrNull(
      right: (_) {
        if (favorite) {
          map[media.id] = media;
        } else {
          map.remove(media.id);
        }
        state = isMovie
            ? loadedState.copyWith(movies: map)
            : loadedState.copyWith(series: map);
      },
    );
    return result;
  }
}
