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
    final result =
        await trendingRepository.getMoviesAndSeries(state.timeWindow);
    final performersRes = await trendingRepository.getPerformers();

    result.when(left: (_) {
      state = HomeState.failed(state.timeWindow);
    }, right: (list) {
      performersRes.when(
        left: (_) {
          HomeState.failed(state.timeWindow);
        },
        right: (performersList) {
          state = HomeState.loaded(
            timeWindow: state.timeWindow,
            moviesAndSeries: list,
            performes: performersList,
          );
        },
      );
    });
  }
}
