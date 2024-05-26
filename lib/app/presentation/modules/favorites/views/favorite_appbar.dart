import 'package:flutter/material.dart';

class FavoritesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoritesAppBar({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: const TextStyle(color: Colors.black),
      title: const Text('Favorites'),
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      bottom: TabBar(
        padding: const EdgeInsets.symmetric(vertical: 10),
        indicator: _Decoration(),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black,
        controller: tabController,
        tabs: const [
          SizedBox(
            height: 30,
            child: Tab(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Movies'),
              ),
            ),
          ),
          SizedBox(
            height: 30,
            child: Tab(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Series'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.5);
}

class _Decoration extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _Painter();
}

class _Painter extends BoxPainter {
  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final paint = Paint()..color = Colors.black38;
    final size = configuration.size ?? Size.zero;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.45 + offset.dx, size.height * 0.80, 14, 6),
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
