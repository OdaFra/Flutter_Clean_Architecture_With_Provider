import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/media/media.dart';
import '../../../../global/global.dart';
import '../../../../utils/go_to_media_details.dart';

class TrendingTitle extends StatelessWidget {
  const TrendingTitle(
      {super.key,
      required this.media,
      required this.width,
      this.showData = true});
  final Media media;
  final double width;
  final bool showData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToMediaDetails(context, media),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              Positioned.fill(
                child: ExtendedImage.network(
                  getImageUrl(media.posterPath),
                  fit: BoxFit.cover,
                  loadStateChanged: (state) {
                    if (state.extendedImageLoadState == LoadState.loading) {
                      return Container(
                        color: Colors.black12,
                      );
                    }
                    return state.completedWidget;
                  },
                ),
              ),
              if (showData)
                Positioned(
                    top: 5,
                    right: 5,
                    child: Opacity(
                      opacity: 0.85,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Chip(
                            backgroundColor: Colors.grey.shade100,
                            labelPadding: const EdgeInsets.all(0.5),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            label: Text(
                              media.voteAverage.toStringAsFixed(1),
                              style: TextStyle(
                                  color: Colors.blueGrey.shade600,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Chip(
                            labelPadding: const EdgeInsets.all(0.5),
                            backgroundColor: Colors.grey.shade100,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            label: Icon(
                              media.type == MediaType.movie
                                  ? Icons.movie
                                  : Icons.tv,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
