import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/network/end_points.dart';
import 'package:shartflix/core/network/network_service.dart';
import 'package:shartflix/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shartflix/models/user_model.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final NetworkService service;

  AuthRemoteDataSourceImpl({required this.service});

  @override
  Future<Either<AppException, UserModel>> login({
    required String email,
    required String password,
  }) async {
    final response = await service.post(
      EndPoints.userLogin(),
      data: {Params.email: email, Params.password: password},
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
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
  Future<Either<AppException, UserModel>> profile() {
    // TODO: implement profile
    throw UnimplementedError();
  }

  @override
  Future<Either<AppException, UserModel>> register({
    required String email,
    required String name,
    required String password,
  }) async {
    final response = await service.post(
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
  Future<Either<AppException, UserModel>> uploadPhoto() {
    // TODO: implement uploadPhoto
    throw UnimplementedError();
  }
}
