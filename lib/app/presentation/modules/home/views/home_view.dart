import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/session_controller.dart';
import '../widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final SessionController sessionController =
        Provider.of(context); //context.read<SessionController>();
    final user = sessionController.state!;

    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            TrendingList()

            // if (user.avatarPath != null)
            //   Image.network(
            //       'https://image.tmdb.org/t/p/w500${user.avatarPath}'),
            // const SizedBox(height: 15),
            // const Text('Home'),
            // Text('${user.id}'),
            // Text(user.username),
            // const SizedBox(height: 15),
            // TextButton(
            //     onPressed: () async {
            //       await sessionController.signOut();
            //       if (mounted) {
            //         Navigator.pushReplacementNamed(context, Routes.signIn);
            //       }
            //     },
            //     child: const Text('Sign Out'))
          ],
        ),
      ),
    );
  }
}
