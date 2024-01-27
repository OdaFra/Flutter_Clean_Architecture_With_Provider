import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../../domain/models/peformer/performer.dart';
import '../../../../../domain/repositories/repositories.dart';
import 'performers_title.dart';

typedef EitherListPerformers = Either<HttpRequestFailure, List<Performer>>;

class TrendingPerformers extends StatefulWidget {
  const TrendingPerformers({super.key});

  @override
  State<TrendingPerformers> createState() => _TrendingPerformersState();
}

class _TrendingPerformersState extends State<TrendingPerformers> {
  late Future<EitherListPerformers> _future;
  late final PageController _pagecontroller;

  // int _currentCard = 0;

  @override
  void initState() {
    _pagecontroller = PageController(viewportFraction: 0.80, initialPage: 1);
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
          future: _future,
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return snapshot.data!.when(
                left: (_) => const Text('Error'),
                right: (list) => Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                              controller: _pagecontroller,
                              scrollDirection: Axis.horizontal,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                final performer = list[index];
                                return PerformersTitle(performer: performer);
                              }),
                        ),
                        // Text('${_currentCard + 1}/${list.length}'),
                        AnimatedBuilder(
                            animation: _pagecontroller,
                            builder: (_, __) {
                              final currentCard =
                                  _pagecontroller.page?.toInt() ?? 1;
                              return Text('${currentCard + 1}/${list.length}');
                            }),
                        const SizedBox(height: 10)
                      ],
                    ));
          }),
    );
  }
}
