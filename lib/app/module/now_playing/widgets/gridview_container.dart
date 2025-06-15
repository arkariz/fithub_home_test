import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridviewContainer extends StatelessWidget {
  const GridviewContainer({
    super.key,
    required this.gridviewItem,
  });

  final SliverChildDelegate gridviewItem;

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        pattern: [
          const WovenGridTile(5 / 10),
          const WovenGridTile(
            5 / 9,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
      ),
      childrenDelegate: gridviewItem,
    );
  }
}