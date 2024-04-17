import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/movie_repository.dart';
import '../../../global/widgets/request_failed.dart';
import '../controllers/movie_controller.dart';
import '../controllers/state/movie_state.dart';

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
          appBar: AppBar(),
          body: controller.state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            failed: () => RequestFailed(onRetry: () => controller.init()),
            loaded: (movie) => const Center(
              child: Text('Movie'),
            ),
          ),
        );
      },
    );
  }
}
