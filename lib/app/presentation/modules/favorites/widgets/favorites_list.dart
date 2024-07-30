import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/media/media.dart';
import '../../../global/global.dart';
import '../../../utils/go_to_media_details.dart';


class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key, required this.items});
  final List<Media> items;

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (_, index) {
        final item = widget.items[index];
        return MaterialButton(
          onPressed: () => goToMediaDetails(context, item),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ExtendedImage.network(
                getImageUrl(
                  item.posterPath,
                ),
                width: 60,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
