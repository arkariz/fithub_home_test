import 'package:fithub_home_test/app/common/routes/app_routes.dart';
import 'package:fithub_home_test/app/common/widgets/d_image.dart';
import 'package:fithub_home_test/app/common/widgets/d_text.dart';
import 'package:fithub_home_test/app/module/empty/empty_screen.dart';
import 'package:fithub_home_test/app/module/favorite/favorite_controller.dart';
import 'package:fithub_home_test/app/module/now_playing/widgets/gridview_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => Visibility(
          visible: controller.movies.isEmpty && !controller.isLoading.value,
          child: const EmptyScreen(
            title: "Your movie list is empty",
            subtitle: "Discover and save movies you love. They’ll appear here!",
          ),
        )),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
          child: Obx(() => Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  controller.movies.clear();
                  await controller.fetchMovies(isRefresh: true);
                },
                child: GridviewContainer(
                  gridviewItem: SliverChildBuilderDelegate(
                    childCount: controller.movies.length,
                    (context, index) => movieItem(index),
                  ),
                ),
              ),
              Visibility(
                visible: controller.isLoading.value,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }

  Widget movieItem(int index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.detailMovie,
          arguments: {
            "movieId": controller.movies[index].id,
            "isFavorite": true,
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: DImage(
                  path: controller.movies[index].posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          DText(
            text: controller.movies[index].title,
            type: DTextType.titleSmall,
            textAlign: TextAlign.center,
          ),
          DText(
            text: controller.movies[index].releaseDate.year.toString(),
            type: DTextType.labelSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}