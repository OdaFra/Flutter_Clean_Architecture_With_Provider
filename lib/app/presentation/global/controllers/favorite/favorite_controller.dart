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
}
