import 'package:fithub_home_test/data/api/model/movie_detail.dart';
import 'package:fithub_home_test/data/api/model/movies.dart';
import 'package:fithub_home_test/data/api/query/favorite_query.dart';
import 'package:fithub_home_test/data/api/query/movie_query.dart';

abstract class MovieRepository {
  Future<Movies> getFavoriteMovies(MovieQuery movieQuery);
  Future<Movies> getMovies(MovieQuery query);
  Future<MovieDetail> getMovieDetail(int id);
  Future<bool> updateFavorite(FavoriteQuery query);
}
