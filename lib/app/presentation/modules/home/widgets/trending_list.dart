// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/enum.dart';
import '../../../../core/utils/utils.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/repositories.dart';
import 'trending_time_window.dart';
import 'widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TrendingTimeWindow(
              timeWindow: _timeWindow,
              onChanged: (timeWindow) {
                setState(() {
                  timeWindow = timeWindow;
                  _future = _repository.getMoviesAndSeries(
                    _timeWindow,
                  );
                });
              }),
          const SizedBox(height: 10),
          AspectRatio(
              aspectRatio: 16 / 8,
              child: LayoutBuilder(builder: (_, contrains) {
                final width = contrains.maxHeight * 0.65;
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
                          left: (failure) => Text(
                                failure.toString(),
                              ),
                          right: (list) {
                            return ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
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
                                  const SizedBox(width: 5.5),
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
