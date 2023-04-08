import 'package:flutter/material.dart';

import '../../../../../main.dart';

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
    final connectivityRepository = Injector.of(context).connectivityRepository;
    final hasInternet = await connectivityRepository.hastInternet;

    if (hasInternet) {
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
