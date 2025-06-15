import 'dart:async';

import 'package:fithub_home_test/app/common/widgets/d_snackbar.dart';
import 'package:fithub_home_test/core/exceptions/exception.dart';
import 'package:fithub_home_test/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  FavoriteController(
    this.movieRepository,
    this.snackbar,
  );
  
  final MovieRepository movieRepository;
  final DSnackbar snackbar;

  final isLoading = false.obs;
  final moviePaging = Movies.empty().obs;
  final movies = <Movie>[].obs;

  Timer? debounce;

  @override
  void onInit() {
    super.onInit();
    _fetchMovies();
  }

  bool scrollListener(Object? notification) {
    if (notification is ScrollNotification) {
      if (notification.metrics.pixels >= notification.metrics.maxScrollExtent - 700) {
        debounce?.cancel();
        debounce = Timer(const Duration(milliseconds: 500), () async {
          await onLoadMore();
        });
      }
    }
    return true;
  }

  Future<void> onLoadMore() async {
    if (moviePaging.value.page == moviePaging.value.totalPages) return;
    await _fetchMovies(page: moviePaging.value.page + 1);
  }

  Future<void> _fetchMovies({int page = 1}) async {
    isLoading.value = true;
    try {
      final query = GetFavoriteQuery(page: page, accountId: 22076012);
      final result = await movieRepository.getFavoriteMovies(query);
      moviePaging.value = result;
      movies.addAll(result.movies);
    } on CoreException catch (e) {
      snackbar.show(e.toInfo().title, e.toInfo().description, type: DSnackbarType.error);
    } finally {
      isLoading.value = false;
    }
    
  }
}
