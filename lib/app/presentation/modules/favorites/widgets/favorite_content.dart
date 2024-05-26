import 'package:flutter/material.dart';

import '../../../global/controllers/favorite/favorite_controller.dart';

class FavoriteContent extends StatelessWidget {
  const FavoriteContent({super.key, required this.state, required this.tabController});
  final FavoriteController state;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const [
        Text('Movie'),
        Text('Series'),
      ],
    );
  }
}
