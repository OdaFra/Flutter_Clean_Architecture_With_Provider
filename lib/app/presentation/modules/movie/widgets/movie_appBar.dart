import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/favorite/favorite_controller.dart';
import '../../../utils/mark_as_favorite.dart';
import '../controllers/movie_controller.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MovieController>();
    final favoriteController = context.watch<FavoriteController>();

    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.transparent,
      actions: controller.state.mapOrNull(
          loaded: (movieState) => [
                favoriteController.state.maybeMap(
                    orElse: () => const SizedBox(),
                    loaded: (favoriteState) => IconButton(
                        onPressed: () => markAsFavorite(
                              context: context,
                              media: movieState.movie.toMedia(),
                              mounted: () => controller.mounted,
                            ),
                        icon: Icon(
                          favoriteState.movies.containsKey(movieState.movie.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.white,
                        )))
              ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
