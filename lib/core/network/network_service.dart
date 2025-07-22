import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/network/responses/base_response.dart';

abstract class NetworkService {
  String get baseUrl;

  String get apiKey;

  Map<String, Object> get headers;

  Future initial();

  void updateHeaders(Map<String, dynamic> data);

  Future<Either<AppException, BaseResponse>> get(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    Object? data,
  });

  Future<Either<AppException, BaseResponse>> post(
    String endPoint, {
    Object? data,
    Map<String, dynamic>? queryParams,
  });
}

enum NetworkEnv { BASE_URL, API_KEY }
