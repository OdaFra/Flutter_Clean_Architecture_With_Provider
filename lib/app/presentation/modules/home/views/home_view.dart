// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/enum.dart';
import '../../../../domain/repositories/repositories.dart';
import '../../../global/controllers/session_controller.dart';
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
          HomeState.loading(TimeWindow.day),
          trendingRepository: context.read<TrendingRepository>(),
        );
        homeController.init();

        return homeController;
      },
      child: Scaffold(
        body: SafeArea(
            child: LayoutBuilder(
          builder: (_, constraints) => RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: constraints.maxHeight,
                child: const Column(
                  children: [
                    SizedBox(height: 10),
                    TrendingList(),
                    SizedBox(height: 10),
                    TrendingPerformers(),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
