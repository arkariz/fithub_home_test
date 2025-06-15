import 'package:fithub_home_test/app/common/extension/date.dart';
import 'package:fithub_home_test/app/common/theme/daycode_theme.dart';
import 'package:fithub_home_test/app/common/widgets/d_scaffold.dart';
import 'package:fithub_home_test/app/module/detail_movie/detail_movie_controller.dart';
import 'package:fithub_home_test/app/module/detail_movie/widgets/poster_appbar.dart';
import 'package:fithub_home_test/app/module/detail_movie/widgets/section_heading.dart';
import 'package:fithub_home_test/app/module/detail_movie/widgets/section_overview.dart';
import 'package:fithub_home_test/app/module/detail_movie/widgets/section_release_genre.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailMovieScreen extends GetView<DetailMovieController> {
  const DetailMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DScaffold(
      body: Obx(() => Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxScrolled) => [
              PosterAppbar(posterPath: controller.detailMovie.value.posterPath),
            ],
            body: RefreshIndicator(
              onRefresh: () async {
                await controller.fetchDetailMovie(isRefresh: true);
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    SectionHeading(
                      title: controller.detailMovie.value.title,
                      runtime: controller.detailMovie.value.runtime,
                      voteAverage: controller.detailMovie.value.voteAverage,
                    ),
                    Divider(thickness: 0.2, color: DaycodeTheme.instance.theme.colorScheme.secondary),
                    SectionReleaseGenre(
                      releaseDate: controller.detailMovie.value.releaseDate.formattedDate,
                      genres: controller.detailMovie.value.genres,
                    ),
                    Divider(thickness: 0.2, color: DaycodeTheme.instance.theme.colorScheme.secondary),
                    SectionOverview(overview: controller.detailMovie.value.overview),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.updateFavorite,
                        child: Text(controller.isFavorite.value ? "Remove from Favorite" : "Add to Favorite"),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
          if (controller.isLoading.value)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      )),
    );
  }
}

