import 'package:dartz/dartz.dart';
import 'package:shartflix/core/app/app_logger.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/network/end_points.dart';
import 'package:shartflix/core/network/network_service.dart';
import 'package:shartflix/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shartflix/models/user_model.dart';
import 'package:shartflix/shared/local/shared_prefs/shared_pref.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final NetworkService _service;
  final SharedPref _sharedPref;

  AuthRemoteDataSourceImpl(this._service, this._sharedPref);

  @override
  Future<Either<AppException, UserModel>> login({
    required String email,
    required String password,
  }) async {
    final response = await _service.post(
      EndPoints.userLogin(),
      data: {Params.email: email, Params.password: password},
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        logger.error(
          "The data is not in the valid format: ${EndPoints.userLogin()}",
          error: r.toString(),
        );
        return Left(
          AppException(
            identifier: EndPoints.userLogin(),
            message: 'The data is not in the valid format',
            statusCode: 0,
          ),
        );
      } else {
        return Right(UserModel.fromJson(jsonData));
      }
    });
  }

  @override
  Future<Either<AppException, UserModel>> register({
    required String email,
    required String name,
    required String password,
  }) async {
    final response = await _service.post(
      EndPoints.userRegister(),
      data: {Params.email: email, Params.password: password, Params.name: name},
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: EndPoints.userRegister(),
            message: 'The data is not in the valid format',
            statusCode: 0,
          ),
        );
      } else {
        return Right(UserModel.fromJson(jsonData));
      }
    });
  }

  @override
  Future<bool> logout() async {
    await _sharedPref.clear();
    return true;
  }
}
