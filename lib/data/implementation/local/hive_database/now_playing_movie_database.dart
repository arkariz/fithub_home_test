import 'package:fithub_home_test/data/implementation/local/entity/movies_entity.dart';
import 'package:fithub_home_test/core/storage/hive/database.dart';

class NowPlayingMovieDatabase {
  NowPlayingMovieDatabase(this.database);

  final Database<MoviesEntity> database;

  Future<void> addNowPlayingMovies(int page, MoviesEntity nowPlayingMovies) async {
    await database.box.put(page, nowPlayingMovies);
  }

  Future<MoviesEntity?> getNowPlayingMovies(int page) async {
    return database.box.get(page);
  }

  Future<void> deleteNowPlayingMovies(int page) async {
    await database.box.delete(page);
  }

  Future<void> deleteAllNowPlayingMovies() async {
    await database.box.clear();
  }

  Future<List<MoviesEntity>> getAllNowPlayingMovies() async {
    return database.box.values.toList();
  }
}
