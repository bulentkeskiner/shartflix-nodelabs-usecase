import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/auth/domain/entities/register_params.dart';
import 'package:shartflix/features/auth/domain/repositories/auth_repository.dart';
import 'package:shartflix/models/user_model.dart';

class RegisterUseCase
    implements UseCase<Either<AppException, UserModel>, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  @override
  Future<Either<AppException, UserModel>> call({required RegisterParams params}) {
    return authRepository.register(
      email: params.email,
      name: params.name,
      password: params.password,
    );
  }
}
