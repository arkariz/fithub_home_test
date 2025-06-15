import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  final bool adult;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final DateTime releaseDate;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final int runtime;

  const MovieDetail({
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
    required this.runtime,
  });

  factory MovieDetail.empty() => MovieDetail(
    adult: false,
    budget: 0,
    genres: const [],
    homepage: '',
    id: 0,
    imdbId: '',
    originalTitle: '',
    overview: '',
    popularity: 0.0,
    posterPath: '',
    productionCompanies: const [],
    releaseDate: DateTime(0),
    status: '',
    tagline: '',
    title: '',
    video: false,
    voteAverage: 0.0,
    voteCount: 0,
    runtime: 0,
  );

  @override
  List<Object?> get props => [
    adult,
    budget,
    genres,
    homepage,
    id,
    imdbId,
    originalTitle,
    overview,
    popularity,
    posterPath,
    productionCompanies,
    releaseDate,
    status,
    tagline,
    title,
    video,
    voteAverage,
    voteCount,
    runtime,
  ];
}

class Genre extends Equatable {
  final int id;
  final String name;

  const Genre({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
    id,
    name,
  ];
}

class ProductionCompany extends Equatable {
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  const ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  @override
  List<Object?> get props => [
    id,
    logoPath,
    name,
    originCountry,
  ];
}
