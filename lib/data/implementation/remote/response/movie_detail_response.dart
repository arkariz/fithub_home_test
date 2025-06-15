
import 'package:fithub_home_test/data/api/model/movie_detail.dart';

class MovieDetailResponse {
  bool? adult;
  int? budget;
  List<GenreResponse>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanyResponse>? productionCompanies;
  DateTime? releaseDate;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  int? runtime;

  MovieDetailResponse({
    this.adult,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.releaseDate,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.runtime,
  });

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) => MovieDetailResponse(
    adult: json["adult"],
    budget: json["budget"],
    genres: json["genres"] == null ? [] : List<GenreResponse>.from(json["genres"]!.map((x) => GenreResponse.fromJson(x))),
    homepage: json["homepage"],
    id: json["id"],
    imdbId: json["imdb_id"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    productionCompanies: json["production_companies"] == null ? [] : List<ProductionCompanyResponse>.from(json["production_companies"]!.map((x) => ProductionCompanyResponse.fromJson(x))),
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    status: json["status"],
    tagline: json["tagline"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    runtime: json["runtime"],
  );

  MovieDetail toModel() => MovieDetail(
    adult: adult ?? false,
    budget: budget ?? 0,
    genres: genres?.map((x) => x.toModel()).toList() ?? [],
    homepage: homepage ?? '',
    id: id ?? 0,
    imdbId: imdbId ?? '',
    originalTitle: originalTitle ?? '',
    overview: overview ?? '',
    popularity: popularity ?? 0.0,
    posterPath: posterPath ?? '',
    productionCompanies: productionCompanies?.map((x) => x.toModel()).toList() ?? [],
    releaseDate: releaseDate ?? DateTime(0),
    status: status ?? '',
    tagline: tagline ?? '',
    title: title ?? '',
    video: video ?? false,
    voteAverage: voteAverage ?? 0.0,
    voteCount: voteCount ?? 0,
    runtime: runtime ?? 0,
  );
}

class GenreResponse {
  int? id;
  String? name;

  GenreResponse({
    this.id,
    this.name,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) => GenreResponse(
    id: json["id"],
    name: json["name"],
  );

  Genre toModel() => Genre(
    id: id ?? 0,
    name: name ?? '',
  );
}

class ProductionCompanyResponse {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanyResponse({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory ProductionCompanyResponse.fromJson(Map<String, dynamic> json) => ProductionCompanyResponse(
    id: json["id"],
    logoPath: json["logo_path"],
    name: json["name"],
    originCountry: json["origin_country"],
  );

  ProductionCompany toModel() => ProductionCompany(
    id: id ?? 0,
    logoPath: logoPath ?? '',
    name: name ?? '',
    originCountry: originCountry ?? '',
  );
}
