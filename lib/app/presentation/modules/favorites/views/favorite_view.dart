import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/favorite/favorite_controller.dart';
import '../../../global/widgets/request_failed.dart';
import '../widgets/favorite_content.dart';
import 'favorite_appbar.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FavoriteController>();
    return Scaffold(
      appBar: FavoritesAppBar(tabController: _tabController),
      body: controller.state.map(
        loading: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        failed: (_) => RequestFailed(
          onRetry: () => controller.init(),
        ),
        loaded: (state) => FavoriteContent(
          state: state,
          tabController: _tabController,
        ),
      ),
    );
  }
}
