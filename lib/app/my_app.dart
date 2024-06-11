import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'generated/assets.gen.dart';
import 'presentation/global/themes/get_theme.dart';
import 'presentation/global/themes/theme_controller.dart';
import 'presentation/router/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        theme: getTheme(themeController.darkMode),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        routes: appRoutes,
        onUnknownRoute: (_) => MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Assets.svgs.error404.svg(),
                  ),
                )),
      ),
    );
  }
}
