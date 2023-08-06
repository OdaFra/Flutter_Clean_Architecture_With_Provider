import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/enum.dart';
import '../../../../core/utils/utils.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/repositories.dart';

typedef EitherListMedia = Either<HttpRequestFailure, List<Media>>;

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<TrendingRepository>();
    return SizedBox(
      height: 250,
      child: Center(
        child: FutureBuilder<EitherListMedia>(
          future: repository.getMoviesAndSeries(
            TimeWindow.day,
          ),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Text('Error');
            }
            return Text(snapshot.data?.toString() ?? 'Empty data');
          },
        ),
      ),
    );
  }
}
