import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/movie_controller.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MovieController>();
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: controller.state.mapOrNull(
          loaded: (_) => [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                    ))
              ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
