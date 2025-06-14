import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GetFavoriteQuery extends Equatable {
  int page;
  int accountId;

  GetFavoriteQuery({
    required this.page,
    required this.accountId,
  });

  @override
  List<Object?> get props => [
    page,
    accountId,
  ];
}