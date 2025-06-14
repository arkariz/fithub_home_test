import 'package:fithub_home_test/data/api/model/movie.dart';
import 'package:hive_ce/hive.dart';

class MovieEntity extends HiveObject {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieEntity({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieEntity.fromModel(Movie model) => MovieEntity(
    adult: model.adult,
    backdropPath: model.backdropPath,
    genreIds: model.genreIds,
    id: model.id,
    originalLanguage: model.originalLanguage,
    originalTitle: model.originalTitle,
    overview: model.overview,
    popularity: model.popularity,
    posterPath: model.posterPath,
    releaseDate: model.releaseDate,
    title: model.title,
    video: model.video,
    voteAverage: model.voteAverage,
    voteCount: model.voteCount,
  );

  Movie toModel() => Movie(
    adult: adult,
    backdropPath: backdropPath,
    genreIds: genreIds,
    id: id,
    originalLanguage: originalLanguage,
    originalTitle: originalTitle,
    overview: overview,
    popularity: popularity,
    posterPath: posterPath,
    releaseDate: releaseDate,
    title: title,
    video: video,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );
}
