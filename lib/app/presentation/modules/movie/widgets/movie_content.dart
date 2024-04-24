import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../global/global.dart';
import '../controllers/state/movie_state.dart';

class MovieContent extends StatelessWidget {
  const MovieContent({super.key, required this.state});
  final MovieStateLoaded state;

  @override
  Widget build(BuildContext context) {
    final movie = state.movie;
    return SingleChildScrollView(
        child: Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 14,
          child: ExtendedImage.network(
            getImageUrl(movie.backdropPath,
                imageQuality: ImageQuality.original),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ],
    ));
  }
}
