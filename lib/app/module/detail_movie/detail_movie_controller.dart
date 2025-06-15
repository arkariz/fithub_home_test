import 'package:fithub_home_test/app/common/widgets/d_snackbar.dart';
import 'package:fithub_home_test/core/exceptions/exception.dart';
import 'package:fithub_home_test/core/network/flavor/network_flavor.dart';
import 'package:fithub_home_test/data/data.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class DetailMovieController extends GetxController {
  DetailMovieController(this.movieRepository, this.snackbar);

  final MovieRepository movieRepository;
  final DSnackbar snackbar;

  final isLoading = false.obs;
  final isFavorite = false.obs;
  final detailMovie = MovieDetail.empty().obs;
  
  late int movieId;

  @override
  void onInit() {
    super.onInit();
    movieId = Get.arguments?["movieId"] ?? 0;
    isFavorite.value = Get.arguments?["isFavorite"] ?? false;
    fetchDetailMovie();
  }

  Future<void> fetchDetailMovie({bool isRefresh = false}) async {
    isLoading.value = !isRefresh;
    await Future.delayed(const Duration(seconds: 5));
    try {
      final result = await movieRepository.getMovieDetail(movieId);
      detailMovie.value = result;
    } on CoreException catch (e) {
      snackbar.show(e.toInfo().title, e.toInfo().description, type: DSnackbarType.error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateFavorite() async {
    try {
      isLoading.value = true;
      final query = FavoriteQuery(
        accountId: GetIt.I<NetworkFlavor>().accountId,
        mediaId: movieId,
        isFavorite: !isFavorite.value,
      );
      final result = await movieRepository.updateFavorite(query);
      if (result) {
        snackbar.show(
          "Success",
          isFavorite.value ? "Movie removed from favorite" : "Movie added to favorite",
          type: DSnackbarType.success,
        );
        isFavorite.value = !isFavorite.value;
      }
    } on CoreException catch (e) {
      snackbar.show(e.toInfo().title, e.toInfo().description, type: DSnackbarType.error);
    } finally {
      isLoading.value = false;
    }
  }
}