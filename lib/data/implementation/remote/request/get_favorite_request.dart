import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GetFavoriteRequest extends Equatable {
  int page;
  int accountId;

  GetFavoriteRequest({
    required this.page,
    required this.accountId,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
    };
  }

  @override
  List<Object?> get props => [
    page,
    accountId,
  ];
}