import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/repositories.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../presentation.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionController = context.read<SessionController>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
            Text('${sessionController.state!.id}'),
            Text(sessionController.state!.username ?? ''),
            const SizedBox(height: 15),
            TextButton(
                onPressed: () async {
                  context.read<AuthenticationRepository>().signOut();
                  Navigator.pushReplacementNamed(context, Routes.signIn);
                },
                child: const Text('Sign Out'))
          ],
        ),
      ),
    );
  }
}
