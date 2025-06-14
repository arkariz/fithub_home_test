import 'package:fithub_home_test/data/api/query/favorite_query.dart';
import 'package:fithub_home_test/data/implementation/remote/request/favorite_request.dart';

extension FavoriteMapper on FavoriteQuery {
  FavoriteRequest toRequest() {
    return FavoriteRequest(
      accountId: accountId,
      mediaId: mediaId,
      isFavorite: isFavorite,
    );
  }
}