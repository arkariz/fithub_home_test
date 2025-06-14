import 'package:fithub_home_test/data/api/query/get_favorite_query.dart';
import 'package:fithub_home_test/data/implementation/remote/request/get_favorite_request.dart';

extension GetFavoriteMapper on GetFavoriteQuery {
  GetFavoriteRequest toRequest() {
    return GetFavoriteRequest(
      page: page,
      accountId: accountId,
    );
  }
}