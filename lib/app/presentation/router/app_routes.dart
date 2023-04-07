import 'package:flutter/material.dart';
import '../modules/modules.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const Splash(),
  };
}
