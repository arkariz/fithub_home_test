class ExceptionResponse {
  final String? code;
  final String? message;

  ExceptionResponse({this.code, this.message});

  factory ExceptionResponse.fromJson(Map<String, dynamic> json) =>
    ExceptionResponse(
      code: json['code'],
      message: json['message'],
    );

  Map<String, dynamic> toJson() => {'code': code, 'message': message};
}
