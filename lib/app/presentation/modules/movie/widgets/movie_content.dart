import 'package:flutter/material.dart';
import '../controllers/state/movie_state.dart';
import 'movie_cast.dart';
import 'movie_header.dart';

class MovieContent extends StatelessWidget {
  const MovieContent({super.key, required this.state});
  final MovieStateLoaded state;

  @override
  Widget build(BuildContext context) {
    final movie = state.movie;
    return SingleChildScrollView(
        child: Column(
      children: [
        MovieHeader(movie: movie),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            movie.overview,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MovieCast(movieId: movie.id),
      ],
    ));
  }
}
