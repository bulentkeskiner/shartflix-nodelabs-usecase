import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shartflix/features/auth/domain/repositories/auth_repository.dart';
import 'package:shartflix/models/user_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<AppException, UserModel>> register({
    required String email,
    required String name,
    required String password,
  }) {
    return authRemoteDataSource.register(email: email, name: name, password: password);
  }

  @override
  Future<Either<AppException, UserModel>> login({
    required String email,
    required String password,
  }) {
    return authRemoteDataSource.login(email: email, password: password);
  }
}
