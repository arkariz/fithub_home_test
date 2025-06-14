class FavoriteResponse {
  bool? success;
  int? statusCode;
  String? statusMessage;

  FavoriteResponse({
    this.success,
    this.statusCode,
    this.statusMessage,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) => FavoriteResponse(
    success: json["success"],
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
  );
}
