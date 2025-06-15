import 'dart:async';

import 'package:fithub_home_test/app/common/widgets/d_snackbar.dart';
import 'package:fithub_home_test/core/exceptions/exception/core/core_exception.dart';
import 'package:fithub_home_test/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NowPlayingController extends GetxController {
  NowPlayingController(
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

  void onSearch(String query) {
    movies.clear();
    _fetchMovies(search: query);
  }

  Future<void> onLoadMore() async {
    if (moviePaging.value.page == moviePaging.value.totalPages) return;
    await _fetchMovies(page: moviePaging.value.page + 1);
  }

  Future<void> _fetchMovies({int page = 1, String? search}) async {
    isLoading.value = true;
    try {
      final query = MovieQuery(page: page, keyword: search);
      final result = await movieRepository.getMovies(query);
      moviePaging.value = result;
      movies.addAll(result.movies);
    } on CoreException catch (e) {
      snackbar.show(e.toInfo().title, e.toInfo().description, type: DSnackbarType.error);
    } finally {
      isLoading.value = false;
    }
    
  }
}
