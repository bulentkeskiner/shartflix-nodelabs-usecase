import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/network/network_service.dart';
import 'package:shartflix/core/network/responses/base_response.dart';
import 'package:shartflix/support/app_lang.dart';

mixin ExceptionHandlerMixin on NetworkService {
  Future<Either<AppException, BaseResponse>> handleException<T extends Object>(
    Future<Response<dynamic>> Function() handler, {
    String endPoint = '',
  }) async {
    String message;
    int statusCode;
    String identifier;
    try {
      final res = await handler();

      return Right(BaseResponse.fromJson(res.data));
    } on SocketException catch (e) {
      message = LocaleKeys.errors_socketException; // tr.json'dan çekildi
      statusCode = 0; // Ağ hatası için özel bir kod
      identifier = 'Socket Exception ${e.message}\n at $endPoint';
    } on DioException catch (e) {
      // e burada zaten DioException tipindedir
      if (e.response != null && e.response!.statusCode != null) {
        statusCode = e.response!.statusCode!;
        var responseError = e.response?.data['response']['message'];
        switch (statusCode) {
          case 400: // Bad Request
            // Sunucudan gelen özel mesaj varsa onu kullan, yoksa dil dosyasından çek
            message = responseError ?? LocaleKeys.errors_badRequest;
            identifier = 'Bad Request (400) at $endPoint: ${e.message}';
            break;
          case 401: // Unauthorized - Kimlik doğrulama hatası (INVALID_CREDENTIALS da buraya düşebilir)
            // Eğer sunucu spesifik 'INVALID_CREDENTIALS' mesajını döndürüyorsa yakalayın
            // Genelde 401 için sunucudan gelen spesifik mesaj beklenir.
            // Eğer sunucudan gelen mesaj yoksa veya yetkisiz olduğunu belirtiyorsa
            // doğrudan 'invalidCredentials' mesajını kullanmak daha spesifik olabilir.
            // Aşağıdaki örnekte, sunucudan gelen mesaj yoksa 'unauthorized' kullanılıyor.
            // Eğer özel olarak INVALID_CREDENTIALS'ı ayırmak isterseniz,
            // 'e.response?.data?['code'] == 'INVALID_CREDENTIALS'' gibi bir kontrol ekleyebilirsiniz.
            message = responseError ?? LocaleKeys.errors_unauthorized;
            // Eğer 401'de sadece bu tip bir hata geliyorsa:
            // message = localizations.errors.invalidCredentials;
            identifier = 'Unauthorized (401) at $endPoint: ${e.message}';
            break;
          case 404: // Not Found
            message = responseError ?? LocaleKeys.errors_notFound;
            identifier = 'Not Found (404) at $endPoint: ${e.message}';
            break;
          case 500: // Internal Server Error
            message = responseError ?? LocaleKeys.errors_internalServerError;
            identifier = 'Internal Server Error (500) at $endPoint: ${e.message}';
            break;
          default:
            message = responseError ?? LocaleKeys.errors_unknownError;
            identifier = 'HTTP Error ($statusCode) at $endPoint: ${e.message}';
            break;
        }
      } else {
        // Ağ bağlantısı sorunları, zaman aşımları vb. (response yoksa)
        message = LocaleKeys.errors_networkOrTimeout; // tr.json'dan çekildi
        statusCode = 0; // Veya ağ hatası için özel bir kod
        identifier =
            'Dio Network/Request Error: ${e.message}\n at $endPoint (Type: ${e.type})';
      }
    } catch (e) {
      // Diğer tüm bilinmeyen hatalar
      message = LocaleKeys.errors_unknownError; // tr.json'dan çekildi
      statusCode = 0;
      identifier = 'unknown error ${e.toString()}\n at $endPoint';
    }

    return Left(
      AppException(message: message, statusCode: statusCode, identifier: identifier),
    );
    /*try {
      final res = await handler();

      return Right(BaseResponse.fromJson(res.data));
    } catch (ex) {
      String message = '';
      String identifier = '';
      int statusCode = 0;
      switch (ex.runtimeType) {
        case SocketException _:
          ex as SocketException;
          message = 'unable to connect to the server.';
          statusCode = 0;
          identifier = 'Socket Exception ${ex.message}\n at  $endPoint';
          break;

        case DioException _:
          ex as DioException;
          message = ex.response?.data?['message'] ?? 'Internal Error occurred';
          statusCode = 0;
          identifier = 'Dio Exception ${ex.message}\n at  $endPoint';
          break;

        default:
          message = 'unknown error occurred';
          statusCode = 0;
          identifier = 'unknown error ${ex.toString()}\n at  $endPoint';
          break;
      }
      return Left(
        AppException(message: message, statusCode: statusCode, identifier: identifier),
      );
    }*/
  }
}
