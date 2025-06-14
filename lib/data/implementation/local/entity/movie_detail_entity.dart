import 'package:fithub_home_test/data/api/model/movie_detail.dart';
import 'package:hive_ce/hive.dart';

class MovieDetailEntity extends HiveObject {
  bool adult;
  int budget;
  List<GenreEntity> genres;
  String homepage;
  int id;
  String imdbId;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompanyEntity> productionCompanies;
  DateTime releaseDate;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetailEntity({
    required this.adult,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.releaseDate,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailEntity.fromModel(MovieDetail model) => MovieDetailEntity(
    adult: model.adult,
    budget: model.budget,
    genres: model.genres.map((e) => GenreEntity.fromModel(e)).toList(),
    homepage: model.homepage,
    id: model.id,
    imdbId: model.imdbId,
    originalTitle: model.originalTitle,
    overview: model.overview,
    popularity: model.popularity,
    posterPath: model.posterPath,
    productionCompanies: model.productionCompanies.map((e) => ProductionCompanyEntity.fromModel(e)).toList(),
    releaseDate: model.releaseDate,
    status: model.status,
    tagline: model.tagline,
    title: model.title,
    video: model.video,
    voteAverage: model.voteAverage,
    voteCount: model.voteCount,
  );

  MovieDetail toModel() => MovieDetail(
    adult: adult,
    budget: budget,
    genres: genres.map((e) => e.toModel()).toList(),
    homepage: homepage,
    id: id,
    imdbId: imdbId,
    originalTitle: originalTitle,
    overview: overview,
    popularity: popularity,
    posterPath: posterPath,
    productionCompanies: productionCompanies.map((e) => e.toModel()).toList(),
    releaseDate: releaseDate,
    status: status,
    tagline: tagline,
    title: title,
    video: video,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );
}

class GenreEntity extends HiveObject {
  int id;
  String name;

  GenreEntity({
    required this.id,
    required this.name,
  });

  factory GenreEntity.fromModel(Genre model) => GenreEntity(
    id: model.id,
    name: model.name,
  );

  Genre toModel() => Genre(
    id: id,
    name: name,
  );
}

class ProductionCompanyEntity extends HiveObject {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompanyEntity({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompanyEntity.fromModel(ProductionCompany model) => ProductionCompanyEntity(
    id: model.id,
    logoPath: model.logoPath,
    name: model.name,
    originCountry: model.originCountry,
  );

  ProductionCompany toModel() => ProductionCompany(
    id: id,
    logoPath: logoPath,
    name: name,
    originCountry: originCountry,
  );
}
