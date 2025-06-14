import 'package:fithub_home_test/data/api/model/movies.dart';
import 'package:fithub_home_test/data/implementation/local/entity/movie_entity.dart';
import 'package:hive_ce/hive.dart';

class MoviesEntity extends HiveObject {
  int page;
  List<MovieEntity> movies;
  int totalPages;
  int totalResults;

  MoviesEntity({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesEntity.fromModel(Movies model) => MoviesEntity(
    page: model.page,
    movies: model.movies.map((e) => MovieEntity.fromModel(e)).toList(),
    totalPages: model.totalPages,
    totalResults: model.totalResults,
  );

  Movies toModel() => Movies(
    page: page,
    movies: movies.map((e) => e.toModel()).toList(),
    totalPages: totalPages,
    totalResults: totalResults,
  );
}