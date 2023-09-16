import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/utils.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/peformer/performer.dart';
import '../../../../domain/repositories/repositories.dart';

typedef EitherListPerformers = Either<HttpRequestFailure, List<Performer>>;

class TrendingPerformers extends StatefulWidget {
  const TrendingPerformers({super.key});

  @override
  State<TrendingPerformers> createState() => _TrendingPerformersState();
}

class _TrendingPerformersState extends State<TrendingPerformers> {
  late Future<EitherListPerformers> _future;

  @override
  void initState() {
    _future = context.read<TrendingRepository>().getPerformers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EitherListPerformers>(
        future: _future,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return snapshot.data!.when(
            left: (_) => const Text('Error'),
            right: (list) => const Text('Performers'),
          );
        });
  }
}
