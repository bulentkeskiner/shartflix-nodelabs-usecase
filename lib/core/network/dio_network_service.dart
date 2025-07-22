import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shartflix/core/app/app_globals.dart';
import 'package:shartflix/core/enum/route_type.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/network/mixin/network_handler_mixin.dart';
import 'package:shartflix/core/network/network_service.dart';
import 'package:shartflix/core/network/responses/base_response.dart';
import 'package:shartflix/core/routing/app_router.dart';
import 'package:shartflix/di_helper.dart';
import 'package:shartflix/features/splash/domain/usecases/delete_token_use_case.dart';
import 'package:shartflix/features/splash/domain/usecases/get_token_use_case.dart';

class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  late Dio dio;

  DioNetworkService();

  @override
  Future initial() async {
    dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await sl<GetTokenUseCase>()();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await sl<DeleteTokenUseCase>()();
            rootNavigatorKey.currentState?.pushNamedAndRemoveUntil(
              RouteType.login.name,
              (route) => false,
            );
          }
          return handler.next(error);
        },
      ),
    );

    if (!kTestMode) {
      dio.options = dioBaseOptions;
      if (kDebugMode) {
        dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
      }
    }
  }

  BaseOptions get dioBaseOptions => BaseOptions(
    baseUrl: baseUrl,
    headers: headers,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  );

  @override
  String get baseUrl => dotenv.env[NetworkEnv.BASE_URL.name] ?? '';

  @override
  String get apiKey => dotenv.env[NetworkEnv.API_KEY.name] ?? '';

  @override
  Map<String, Object> get headers => {
    'accept': 'application/json',
    'content-type': 'application/json',
  };

  @override
  Map<String, dynamic>? updateHeaders(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    if (!kTestMode) {
      dio.options.headers = headers;
    }
    return header;
  }

  @override
  Future<Either<AppException, BaseResponse>> get(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    Object? data,
  }) {
    queryParams ??= {};
    final res = handleException(
      () => dio.get(endPoint, queryParameters: queryParams, data: data),
      endPoint: endPoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, BaseResponse>> post(
    String endPoint, {
    Object? data,
    Map<String, dynamic>? queryParams,
  }) {
    queryParams ??= {};
    final res = handleException(
      () => dio.post(endPoint, data: data, queryParameters: queryParams),
      endPoint: endPoint,
    );
    return res;
  }
}
