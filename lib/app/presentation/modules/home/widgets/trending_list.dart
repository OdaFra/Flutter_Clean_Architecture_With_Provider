import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/enum.dart';
import '../../../../core/utils/utils.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/repositories.dart';
import '../../../global/global.dart';

typedef EitherListMedia = Either<HttpRequestFailure, List<Media>>;

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  late final Future<EitherListMedia> _future;

  @override
  void initState() {
    final repository = context.read<TrendingRepository>();
    _future = repository.getMoviesAndSeries(TimeWindow.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Center(
        child: FutureBuilder<EitherListMedia>(
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
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        final media = list[index];
                        return Image.network(
                          getImageUrl(media.posterPath),
                        );
                      });
                });
          },
        ),
      ),
    );
  }
}
