import 'package:flutter/material.dart';
import 'presentation/modules/home/views/home_view.dart';
import 'presentation/modules/movie/views/movie_view.dart';
import 'presentation/router/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash,
          routes: appRoutes,
          onGenerateRoute: (settings) {
            final name = settings.name ?? '';
            if (name == Routes.movie) {
              return MaterialPageRoute(
                  settings: const RouteSettings(name: Routes.home),
                  builder: (_) => const HomeView());
            }

            if (name.startsWith(Routes.movie)) {
              final id = int.parse(
                name.substring(name.lastIndexOf('/') + 1, name.length),
              );
              return MaterialPageRoute(
                builder: (_) => MovieView(movieId: id),
                settings: settings,
              );
            }
            return null;
          }),
    );
  }
}
