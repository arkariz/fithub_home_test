import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class FavoriteQuery extends Equatable {
  int accountId;
  int mediaId;
  bool isFavorite;

  FavoriteQuery({
    required this.accountId,
    required this.mediaId,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [
    accountId,
    mediaId,
    isFavorite,
  ];
}