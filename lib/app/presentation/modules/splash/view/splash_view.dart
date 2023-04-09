import 'package:flutter/material.dart';

import '../../../../../main.dart';
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
    final injector = Injector.of(context);
    final connectivityRepository = injector.connectivityRepository;
    final hasInternet = await connectivityRepository.hastInternet;

    if (hasInternet) {
      final authentication = injector.authenticationRepository;
      final isSignedIn = await authentication.isSignedIn;
      if (isSignedIn) {
        final user = await authentication.getUserData();
        if (user != null) {
          //HOME
        } else {
          //Sign In
        }
      } else if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          Routes.signIn,
        );
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
            width: 80, height: 80, child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
