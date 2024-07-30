import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/movies/movies.dart';
import '../../../global/extensions/build_context_ext.dart';
import '../../../global/global.dart';

class MovieHeader extends StatelessWidget {
  const MovieHeader({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
            aspectRatio: 16 / 14,
            child: movie.backdropPath != null
                ? ExtendedImage.network(
                    getImageUrl(movie.backdropPath!,
                        imageQuality: ImageQuality.original),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.black54,
                  )),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54, Colors.black]),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(
              top: 25,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: context.textTheme.titleSmall
                            ?.copyWith(color: Colors.white),
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
                                        fontSize: 10,
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
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                            value: (movie.voteAverage / 10).clamp(0.0, 1.0),
                          ),
                        ),
                        Text(
                          movie.voteAverage.toStringAsPrecision(2),
                          style: context.textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12)
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
