import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class FavoriteRequest extends Equatable {
  String mediaType;
  int accountId;
  int mediaId;
  bool isFavorite;

  FavoriteRequest({
    this.mediaType = 'movie',
    required this.accountId,
    required this.mediaId,
    required this.isFavorite,
  });

  Map<String, dynamic> toJson() {
    return {
      'media_type': mediaType,
      'media_id': mediaId,
      'favorite': isFavorite,
    };
  }

  @override
  List<Object?> get props => [
    mediaType,
    accountId,
    mediaId,
    isFavorite,
  ];
}