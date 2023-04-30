import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../presentation.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
            const SizedBox(height: 15),
            TextButton(
                onPressed: () async {
                   Injector.of(context)
                      .authenticationRepository
                      .signUout();
                  Navigator.pushReplacementNamed(context, Routes.signIn);
                },
                child: const Text('Sign Out'))
          ],
        ),
      ),
    );
  }
}
