import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

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
        Stack(
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                        Colors.black
                      ]),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(
                  top: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      children: movie.genres
                          .map((genre) => Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  genre.name,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 12)
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
