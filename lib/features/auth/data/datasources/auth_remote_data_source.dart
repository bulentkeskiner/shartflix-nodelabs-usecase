import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<AppException, UserModel>> register({
    required String email,
    required String name,
    required String password,
  });

  Future<Either<AppException, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<AppException, UserModel>> profile();

  Future<Either<AppException, UserModel>> uploadPhoto();
}
