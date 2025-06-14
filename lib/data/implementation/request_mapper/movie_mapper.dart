import 'package:fithub_home_test/data/api/query/movie_query.dart';
import 'package:fithub_home_test/data/implementation/remote/request/movie_request.dart';

extension MovieMapper on MovieQuery {
  MovieRequest toRequest() {
    return MovieRequest(
      page: page,
      keyword: keyword,
    );
  }
}