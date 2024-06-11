import 'package:flutter/material.dart';
import '../modules/favorites/views/favorite_view.dart';
import '../modules/home/views/views.dart';
import '../modules/modules.dart';
import '../modules/offline/offline.dart';
import '../modules/profilles/view/profile_view.dart';
import '../modules/sign_in/views/views.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const Splash(),
    Routes.signIn: (context) => const SignInView(),
    Routes.home: (context) => const HomeView(),
    Routes.offline: (context) => const OfflineView(),
    Routes.favorite: (context) => const FavoriteView(),
    Routes.profile: (context) => const ProfileView(),
    // Routes.movie: (context) => MovieView(
    //       movieId: ModalRoute.of(context)?.settings.arguments as int,
    //     )
  };
}
