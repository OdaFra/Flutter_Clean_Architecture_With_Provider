import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/peformer/performer.dart';
import '../../../../global/global.dart';
import '../widgets.dart';

class PerformersTitle extends StatelessWidget {
  const PerformersTitle({super.key, required this.performer});

  final Performer performer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned.fill(
              child: ExtendedImage.network(
                getImageUrl(
                  performer.profilePath,
                  imageQuality: ImageQuality.original,
                ),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8).copyWith(bottom: 35),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.transparent,
                        Colors.grey.shade600,
                      ])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        performer.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (performer.knownFor.isNotEmpty)
                        SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: performer.knownFor
                                  .take(3)
                                  .map(
                                    (media) => TrendingTitle(
                                      showData: false,
                                      media: media,
                                      width: 100 * 0.70,
                                    ),
                                  )
                                  .toList(),
                            ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
