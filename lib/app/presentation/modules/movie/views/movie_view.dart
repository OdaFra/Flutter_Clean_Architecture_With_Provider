import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/movie_repository.dart';
import '../../../global/widgets/request_failed.dart';
import '../controllers/movie_controller.dart';
import '../controllers/state/movie_state.dart';
import '../widgets/movie_appBar.dart';
import '../widgets/movie_content.dart';

class MovieView extends StatelessWidget {
  const MovieView({super.key, required this.movieId});
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieController(
        MovieState.loading(),
        movieRepository: context.read<MovieRepository>(),
        movieId: movieId,
      )..init(),
      builder: (context, _) {
        final controller = context.watch<MovieController>();
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const MovieAppBar(),
          body: controller.state.map(
            loading: (_) => const Center(child: CircularProgressIndicator()),
            failed: (_) => RequestFailed(onRetry: () => controller.init()),
            loaded: (state) => MovieContent(state: state),
          ),
        );
      },
    );
  }
}
