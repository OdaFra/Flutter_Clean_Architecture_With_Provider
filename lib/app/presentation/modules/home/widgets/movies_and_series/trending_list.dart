import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../../domain/models/media/media.dart';
import '../../../../global/widgets/request_failed.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/state/home_state.dart';
import 'trending_time_window.dart';
import '../widgets.dart';

typedef EitherListMedia = Either<HttpRequestFailure, List<Media>>;

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = context.watch<HomeController>();
    final moviesAndSeriesState = homeController.state.moviesAndSeriesState;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TrendingTimeWindow(
            timeWindow: moviesAndSeriesState.timeWindow,
            onChanged: (timeWindow) =>
                homeController.onTimeWindowChanged(timeWindow),
          ),
          const SizedBox(height: 10),
          AspectRatio(
              aspectRatio: 16 / 8,
              child: LayoutBuilder(builder: (_, contrains) {
                final width = contrains.maxHeight * 0.70;
                return Center(
                    child: moviesAndSeriesState.when(
                        loading: (_) =>
                            const Center(child: CircularProgressIndicator()),
                        failed: (_) => RequestFailed(
                              onRetry: () {
                                homeController.loadMoviesAndSeries(
                                  moviesAndSeriesState:
                                      MoviesAndSeriesState.loading(
                                    moviesAndSeriesState.timeWindow,
                                  ),
                                );
                              },
                            ),
                        loaded: (_, list) => ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              itemCount: list.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                final media = list[index];
                                return SizedBox(
                                    width: width,
                                    height: double.infinity,
                                    child: TrendingTitle(
                                      media: media,
                                      width: width,
                                    ));
                              },
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 6),
                            )));
              })),
        ],
      ),
    );
  }
}

// VERSION ANTERIOR
/*
// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/enums/enum.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../../domain/models/media/media.dart';
import '../../../../../domain/repositories/repositories.dart';
import '../../../../global/widgets/request_failed.dart';
import 'trending_time_window.dart';
import '../widgets.dart';

typedef EitherListMedia = Either<HttpRequestFailure, List<Media>>;

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  TrendingRepository get _repository => context.read();

  late Future<EitherListMedia> _future;

  TimeWindow _timeWindow = TimeWindow.day;

  @override
  void initState() {
    //final repository = context.read<TrendingRepository>();
    _future = _repository.getMoviesAndSeries(_timeWindow);
    super.initState();
  }

  void _updateFuture(TimeWindow timeWindow) {
    setState(() {
      _timeWindow = timeWindow;
      _future = _repository.getMoviesAndSeries(
        _timeWindow,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TrendingTimeWindow(timeWindow: _timeWindow, onChanged: _updateFuture),
          const SizedBox(height: 10),
          AspectRatio(
              aspectRatio: 16 / 8,
              child: LayoutBuilder(builder: (_, contrains) {
                final width = contrains.maxHeight * 0.70;
                return Center(
                  child: FutureBuilder<EitherListMedia>(
                    key: ValueKey(_future),
                    future: _future,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return snapshot.data!.when(
                          left: (failure) => RequestFailed(
                              onRetry: () => _updateFuture(_timeWindow)),
                          //  Text(
                          //       failure.toString(),
                          //     ),
                          right: (list) {
                            return ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              itemCount: list.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                final media = list[index];
                                return SizedBox(
                                    width: width,
                                    height: double.infinity,
                                    child: TrendingTitle(
                                      media: media,
                                      width: width,
                                    ));
                              },
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 6),
                            );
                          });
                    },
                  ),
                );
              })),
        ],
      ),
    );
  }
}


 */