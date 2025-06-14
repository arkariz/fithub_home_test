import 'package:fithub_home_test/data/implementation/local/entity/movie_detail_entity.dart';
import 'package:fithub_home_test/core/storage/hive/database.dart';

class MovieDetailDatabase {
  MovieDetailDatabase(this.database);

  final Database<MovieDetailEntity> database;

  Future<void> addMovieDetail(int id, MovieDetailEntity movieDetail) async {
    await database.box.put(id, movieDetail);
  }

  Future<MovieDetailEntity?> getMovieDetail(int id) async {
    return database.box.get(id);
  }

  Future<void> deleteMovieDetail(int id) async {
    await database.box.delete(id);
  }

  Future<void> deleteAllMovieDetail() async {
    await database.box.clear();
  }

  Future<List<MovieDetailEntity>> getAllMovieDetail() async {
    return database.box.values.toList();
  }
}
