import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MovieQuery extends Equatable {
  int page;
  String? keyword;

  MovieQuery({
    required this.page,
    this.keyword,
  });

  @override
  List<Object?> get props => [
    page,
    keyword,
  ];
}