import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MovieRequest extends Equatable {
  int page;
  String? keyword;

  MovieRequest({
    required this.page,
    this.keyword,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      if (keyword != null) 'keyword': keyword,
    };
  }

  @override
  List<Object?> get props => [
    page,
    keyword,
  ];
}