import 'package:fithub_home_test/app/common/routes/app_routes.dart';
import 'package:fithub_home_test/app/common/widgets/d_snackbar.dart';
import 'package:fithub_home_test/app/module/dashboard/dashboard_controller.dart';
import 'package:fithub_home_test/app/module/dashboard/dashboard_screen.dart';
import 'package:fithub_home_test/app/module/detail_movie/detail_movie_controller.dart';
import 'package:fithub_home_test/app/module/detail_movie/detail_movie_screen.dart';
import 'package:fithub_home_test/app/module/favorite/favorite_controller.dart';
import 'package:fithub_home_test/app/module/now_playing/now_playing_controller.dart';
import 'package:fithub_home_test/data/data.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class AppPages {
  AppPages._();
  static final routes = [
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DashboardController());
        Get.lazyPut(() => NowPlayingController(GetIt.I<MovieRepository>(), DSnackbar()));
        Get.lazyPut(() => FavoriteController(GetIt.I<MovieRepository>(), DSnackbar()));
      }),
    ),
    GetPage(
      name: AppRoutes.detailMovie,
      page: () => const DetailMovieScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DetailMovieController(GetIt.I<MovieRepository>(), DSnackbar()));
      }),
    ),
  ];
}
