import 'package:fithub_home_test/data/api/model/movie.dart';
import 'package:fithub_home_test/data/api/model/movies.dart';

class MoviesResponse {
  int? page;
  List<MovieResponse>? movies;
  int? totalPages;
  int? totalResults;

  MoviesResponse({
    this.page,
    this.movies,
    this.totalPages,
    this.totalResults,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => MoviesResponse(
    page: json["page"],
    movies: json["results"] == null ? [] : List<MovieResponse>.from(json["results"]!.map((x) => MovieResponse.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Movies toModel() => Movies(
    page: page ?? 0,
    movies: movies?.map((x) => x.toModel()).toList() ?? [],
    totalPages: totalPages ?? 0,
    totalResults: totalResults ?? 0,
  );
}

class MovieResponse {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieResponse({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Movie toModel() => Movie(
    adult: adult ?? false,
    backdropPath: backdropPath ?? '',
    genreIds: genreIds ?? [],
    id: id ?? 0,
    originalLanguage: originalLanguage ?? '',
    originalTitle: originalTitle ?? '',
    overview: overview ?? '',
    popularity: popularity ?? 0.0,
    posterPath: posterPath ?? '',
    releaseDate: releaseDate ?? DateTime.now(),
    title: title ?? '',
    video: video ?? false,
    voteAverage: voteAverage ?? 0.0,
    voteCount: voteCount ?? 0,
  );
}
