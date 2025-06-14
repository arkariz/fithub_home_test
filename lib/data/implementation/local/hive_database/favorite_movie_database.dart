import 'package:fithub_home_test/data/implementation/local/entity/movies_entity.dart';
import 'package:fithub_home_test/core/storage/hive/database.dart';

class FavoriteMovieDatabase {
  FavoriteMovieDatabase(this.database);

  final Database<MoviesEntity> database;

  Future<void> addFavoriteMovies(int page, MoviesEntity favoriteMovies) async {
    await database.box.put(page, favoriteMovies);
  }

  Future<MoviesEntity?> getFavoriteMovies(int page) async {
    return database.box.get(page);
  }

  Future<void> deleteFavoriteMovies(int page) async {
    await database.box.delete(page);
  }

  Future<void> deleteAllFavoriteMovies() async {
    await database.box.clear();
  }

  Future<List<MoviesEntity>> getAllFavoriteMovies() async {
    return database.box.values.toList();
  }
}
