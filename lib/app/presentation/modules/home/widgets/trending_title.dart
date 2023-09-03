import 'package:flutter/material.dart';

import '../../../../domain/models/media/media.dart';
import '../../../global/global.dart';

class TrendingTitle extends StatelessWidget {
  const TrendingTitle({super.key, required this.media, required this.width});
  final Media media;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: width,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                getImageUrl(media.posterPath),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 5,
                right: 5,
                child: Chip(
                  backgroundColor: Colors.grey.shade400,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  label: Text(
                    media.voteAverage.toStringAsFixed(1),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
