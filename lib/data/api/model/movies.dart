import 'package:equatable/equatable.dart';
import 'package:fithub_home_test/data/api/model/movie.dart';

class Movies extends Equatable {
  final int page;
  final List<Movie> movies;
  final int totalPages;
  final int totalResults;

  const Movies({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory Movies.empty() => const Movies(
    page: 0,
    movies: [],
    totalPages: 0,
    totalResults: 0,
  );

  @override
  List<Object?> get props => [
    page,
    movies,
    totalPages,
    totalResults,
  ];
}