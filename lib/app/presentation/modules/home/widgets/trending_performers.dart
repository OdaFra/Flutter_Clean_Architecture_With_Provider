import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/utils.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/peformer/performer.dart';
import '../../../../domain/repositories/repositories.dart';
import '../../../global/utils/get_image_url.dart';

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
    final width = MediaQuery.of(context).size.width;
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
                right: (list) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      final performer = list[index];
                      return SizedBox(
                        width: width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ExtendedImage.network(
                                    getImageUrl(performer.profilePath),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
          }),
    );
  }
}
