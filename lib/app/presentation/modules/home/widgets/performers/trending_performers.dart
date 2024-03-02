import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global/widgets/request_failed.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/state/home_state.dart';
import 'performers_title.dart';

class TrendingPerformersList extends StatefulWidget {
  const TrendingPerformersList({super.key});

  @override
  State<TrendingPerformersList> createState() => _TrendingPerformersListState();
}

class _TrendingPerformersListState extends State<TrendingPerformersList> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = context.watch<HomeController>();
    final performersState = homeController.state.performersState;
    return Expanded(
      child: performersState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          failed: () => RequestFailed(
                onRetry: () {
                  homeController.loadPerformers(
                    performersState: const PerformersState.loading(),
                  );
                },
              ),
          loaded: (list) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final performer = list[index];
                      return PerformersTitle(performer: performer);
                    }),
                // Text('${_currentCard + 1}/${list.length}'),
                Positioned(
                  bottom: 20,
                  child: AnimatedBuilder(
                      animation: _pageController,
                      builder: (_, __) {
                        final currentCard = _pageController.page?.toInt() ?? 0;
                        return Row(
                          children: List.generate(
                            list.length,
                            (index) => Icon(
                              Icons.circle,
                              size: 14,
                              color: currentCard == index
                                  ? Colors.white
                                  : Colors.white30,
                            ),
                          ),
                        );
                        // Text(
                        //     '${currentCard + 1}/${list.length}');
                      }),
                ),
                const SizedBox(height: 10)
              ],
            );
          }),
    );
  }
}


//VERSION ANTERIOR DE TRENDING PERFORMERSs

/**
 
 typedef EitherListPerformers = Either<HttpRequestFailure, List<Performer>>;

class TrendingPerformers extends StatefulWidget {
  const TrendingPerformers({super.key});

  @override
  State<TrendingPerformers> createState() => _TrendingPerformersList();
}

class _TrendingPerformersList extends State<TrendingPerformers> {
  late Future<EitherListPerformers> _future;
  late final PageController _pagecontroller;

  // int _currentCard = 0;

  @override
  void initState() {
    _pagecontroller = PageController();
    //viewportFraction: 0.80, initialPage: 1);
    // _pagecontroller.addListener(() {
    //   setState(() {
    //     _currentCard = _pagecontroller.page!.toInt();
    //   });
    // });
    _future = context.read<TrendingRepository>().getPerformers();
    super.initState();
  }

  @override
  void dispose() {
    _pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<EitherListPerformers>(
          key: ValueKey(_future),
          future: _future,
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return snapshot.data!.when(
                left: (_) => RequestFailed(onRetry: () {
                      setState(() {
                        _future =
                            context.read<TrendingRepository>().getPerformers();
                      });
                    }),
                right: (list) => Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView.builder(
                            controller: _pagecontroller,
                            scrollDirection: Axis.horizontal,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final performer = list[index];
                              return PerformersTitle(performer: performer);
                            }),
                        // Text('${_currentCard + 1}/${list.length}'),
                        Positioned(
                          bottom: 20,
                          child: AnimatedBuilder(
                              animation: _pagecontroller,
                              builder: (_, __) {
                                final currentCard =
                                    _pagecontroller.page?.toInt() ?? 0;
                                return Row(
                                  children: List.generate(
                                    list.length,
                                    (index) => Icon(
                                      Icons.circle,
                                      size: 14,
                                      color: currentCard == index
                                          ? Colors.white
                                          : Colors.white30,
                                    ),
                                  ),
                                );
                                // Text(
                                //     '${currentCard + 1}/${list.length}');
                              }),
                        ),
                        const SizedBox(height: 10)
                      ],
                    ));
          }),
    );
  }
}


 */