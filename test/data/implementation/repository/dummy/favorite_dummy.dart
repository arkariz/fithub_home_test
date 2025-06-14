import 'package:fithub_home_test/data/implementation/remote/response/favorite_response.dart';

FavoriteResponse favoriteDummy(bool isSuccess) => FavoriteResponse(
  success: isSuccess,
  statusCode: isSuccess ? 200 : 500,
  statusMessage: isSuccess ? "Favorite updated successfully" : "Favorite update failed",
);