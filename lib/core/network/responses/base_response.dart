import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';

class BaseResponse {
  final int code;
  final String message;
  final dynamic data;

  BaseResponse({required this.code, required this.message, required this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      code: json['response']['code'] ?? 0,
      message: json['response']['message'] ?? '',
      data: json['data'],
    );
  }

  @override
  String toString() {
    return 'Response{statusCode: $code, statusMessage: $message, data: $data}';
  }
}

extension ResponseExtension on BaseResponse {
  Right<AppException, BaseResponse> get toRight => Right(this);
}
