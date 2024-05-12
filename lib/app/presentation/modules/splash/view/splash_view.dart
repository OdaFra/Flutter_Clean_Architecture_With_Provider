// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/repositories.dart';
import '../../../global/controllers/favorite/favorite_controller.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../router/router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    final connectivityRepository = context.read<ConnectivityRepository>();
    final authenticationRepository = context.read<AuthenticationRepository>();
    final accountRepository = context.read<AccountRepository>();
    final hasInternet = await connectivityRepository.hastInternet;
    final sessionController = context.read<SessionController>();
    final favoriteController = context.read<FavoriteController>();

    if (!hasInternet) {
      return _goTo(Routes.offline);
    }

    final isSignedIn = await authenticationRepository.isSignedIn;

    if (!isSignedIn) {
      return _goTo(Routes.signIn);
    }

    final user = await accountRepository.getUserData();

    if (user != null) {
      sessionController.setUser(user);
      favoriteController.init();
      return _goTo(Routes.home);
    }
  }

  Future<void> _goTo(String routeName) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            SizedBox(width: 80, height: 80, child: CircularProgressIndicator()),
      ),
    );
  }
}
