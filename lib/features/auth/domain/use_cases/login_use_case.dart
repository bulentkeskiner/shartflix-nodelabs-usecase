import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/auth/domain/entities/login_params.dart';
import 'package:shartflix/features/auth/domain/repositories/auth_repository.dart';
import 'package:shartflix/models/user_model.dart';

class LoginUseCase implements UseCase<Either<AppException, UserModel>, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  Future<Either<AppException, UserModel>> call({required LoginParams params}) {
    return authRepository.login(email: params.email, password: params.password);
  }
}
