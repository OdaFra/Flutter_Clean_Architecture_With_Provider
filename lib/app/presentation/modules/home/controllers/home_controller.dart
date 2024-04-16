import '../../../../core/enums/timeWindows.dart';
import '../../../../domain/repositories/repositories.dart';
import '../../../state_notifier.dart';
import 'state/home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController(
    super.state, {
    required this.trendingRepository,
  });

  final TrendingRepository trendingRepository;

  Future<void> init() async {
    await loadMoviesAndSeries();
    await loadPerformers();
  }

  Future<void> loadMoviesAndSeries({
    MoviesAndSeriesState? moviesAndSeriesState,
  }) async {
    if (moviesAndSeriesState != null) {
      state = state.copyWith(
        moviesAndSeriesState: moviesAndSeriesState,
      );
    }

    final result = await trendingRepository.getMoviesAndSeries(
      state.moviesAndSeriesState.timeWindow,
    );

    state = result.when(
        left: (_) => state.copyWith(
              moviesAndSeriesState: MoviesAndSeriesState.failed(
                state.moviesAndSeriesState.timeWindow,
              ),
            ),
        right: (list) => state.copyWith(
              moviesAndSeriesState: MoviesAndSeriesState.loaded(
                timeWindow: state.moviesAndSeriesState.timeWindow,
                list: list,
              ),
            ));
  }

  Future<void> loadPerformers({PerformersState? performersState}) async {
    if (performersState != null) {
      state = state.copyWith(
        performersState: performersState,
      );
    }

    final performersResult = await trendingRepository.getPerformers();

    state = performersResult.when(
        left: (_) => state.copyWith(
              performersState: const PerformersState.failed(),
            ),
        right: (list) => state.copyWith(
              performersState: PerformersState.loaded(list),
            ));
  }

  void onTimeWindowChanged(TimeWindow timeWindow) {
    if (state.moviesAndSeriesState.timeWindow != timeWindow) {
      state = state.copyWith(
        moviesAndSeriesState: state.moviesAndSeriesState.copyWith(
          timeWindow: timeWindow,
        ),
      );
      loadMoviesAndSeries();
    }
  }
}
