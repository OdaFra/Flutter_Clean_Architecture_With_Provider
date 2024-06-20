// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../domain/repositories/repositories.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../router/routes.dart';
import '../controllers/home_controller.dart';
import '../controllers/state/home_state.dart';
import '../widgets/performers/trending_performers.dart';
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

    return ChangeNotifierProvider(
      create: (_) {
        final homeController = HomeController(
          HomeState(),
          trendingRepository: context.read<TrendingRepository>(),
        );
        homeController.init();

        return homeController;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.favorite,
                  );
                },
                icon: const Icon(Icons.favorite)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.profile);
                },
                icon: const Icon(Icons.person))
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => RefreshIndicator(
              onRefresh: context.read<HomeController>().init,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: constraints.maxHeight,
                  child: const Column(
                    children: [
                      SizedBox(height: 10),
                      TrendingList(),
                      SizedBox(height: 10),
                      TrendingPerformersList(),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
