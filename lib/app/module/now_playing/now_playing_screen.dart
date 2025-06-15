
import 'dart:async';

import 'package:fithub_home_test/app/common/routes/app_routes.dart' show AppRoutes;
import 'package:fithub_home_test/app/common/widgets/d_image.dart';
import 'package:fithub_home_test/app/common/widgets/d_text.dart';
import 'package:fithub_home_test/app/module/now_playing/now_playing_controller.dart';
import 'package:fithub_home_test/app/module/now_playing/widgets/gridview_container.dart';
import 'package:fithub_home_test/app/module/now_playing/widgets/search_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NowPlayingScreen extends GetView<NowPlayingController> {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
      child: Obx(() => Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxScrolled) => [
              SearchAppbar(
                onSearch: (query) {
                  controller.debounce?.cancel();
                  controller.debounce = Timer(const Duration(milliseconds: 500), () async {
                    controller.onSearch(query);
                  });
                }
              ),
            ],
            body: NotificationListener(
              onNotification: (notification) {
                return controller.scrollListener(notification);
              },
              child: RefreshIndicator(
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
            ),
          ),
          if (controller.isLoading.value)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      )),
    );
  }

  Widget movieItem(int index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.detailMovie,
          arguments: {
            "movieId": controller.movies[index].id,
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