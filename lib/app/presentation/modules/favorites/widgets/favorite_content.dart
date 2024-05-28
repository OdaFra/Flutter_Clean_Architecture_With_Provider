import 'package:flutter/material.dart';

import '../../../global/controllers/favorite/favorite_state.dart';
import 'favorites_list.dart';

class FavoriteContent extends StatelessWidget {
  const FavoriteContent(
      {super.key, required this.state, required this.tabController});
  final FavoriteStateLoaded state;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        FavoriteList(items: state.movies.values.toList()),
        FavoriteList(items: state.series.values.toList())
      ],
    );
  }
}
