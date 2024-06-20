import 'package:flutter/material.dart';

class FavoritesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoritesAppBar({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Favorites'),
      centerTitle: true,
      elevation: 0,
      bottom: TabBar(
        padding: const EdgeInsets.symmetric(vertical: 3.5),
        indicator: const _Decoration(
          color: Colors.blue,
          width: 14,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        controller: tabController,
        tabs: const [
          Tab(
            child: Text('Movies'),
          ),
          Tab(
            child: Text('Series'),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.5);
}

class _Decoration extends Decoration {
  final double width;
  final Color color;

  const _Decoration({
    required this.width,
    required this.color,
  });
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _Painter(color: color, width: width);
}

class _Painter extends BoxPainter {
  final double width;
  final Color color;

  const _Painter({
    required this.width,
    required this.color,
  });
  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final paint = Paint()..color = color;
    final size = configuration.size ?? Size.zero;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.45 + offset.dx,
          size.height * 0.80,
          width,
          width * 0.4,
        ),
        const Radius.circular(4),
      ),
      paint,
    );

    // canvas.drawCircle(
    //   Offset(size.width * 0.5 + offset.dx, size.height * 0.80),
    //   4,
    //   paint,
    // );
  }
}
