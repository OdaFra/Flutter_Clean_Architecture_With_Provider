import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/either.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/peformer/performer.dart';
import '../../../../domain/repositories/movie_repository.dart';
import '../../../global/extensions/build_context_ext.dart';
import '../../../global/utils/get_image_url.dart';
import '../../../global/widgets/request_failed.dart';

class MovieCast extends StatefulWidget {
  const MovieCast({super.key, required this.movieId});
  final int movieId;

  @override
  State<MovieCast> createState() => _MovieCastState();
}

class _MovieCastState extends State<MovieCast> {
  late Future<Either<HttpRequestFailure, List<Performer>>> _future;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  void _initFuture() {
    _future = context.read<MovieRepository>().getCatsByMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<HttpRequestFailure, List<Performer>>>(
        key: ValueKey(_future),
        future: _future,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data!.when(
            left: (_) => RequestFailed(onRetry: () {
              setState(() {
                _initFuture();
              });
            }),
            right: (cast) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Cast', style: context.textTheme.titleMedium),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, __) => const SizedBox(width: 6.5),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: cast.length,
                      itemBuilder: (_, int index) {
                        final performer = cast[index];
                        return Column(
                          children: [
                            Flexible(
                              child: LayoutBuilder(
                                builder: (_, constraints) {
                                  final size = constraints.maxHeight;
                                  return ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(size / 2),
                                    child: ExtendedImage.network(
                                      getImageUrl(performer.profilePath),
                                      height: size,
                                      width: size,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              performer.name,
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              );
            },
          );
        });
  }
}
