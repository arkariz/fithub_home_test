class ExceptionResponse {
  final int? code;
  final String? message;

  ExceptionResponse({this.code, this.message});

  factory ExceptionResponse.fromJson(Map<String, dynamic> json) =>
    ExceptionResponse(
      code: json['status_code'],
      message: json['status_message'],
    );

  Map<String, dynamic> toJson() => {
    'status_code': code,
    'status_message': message,
  };
}
