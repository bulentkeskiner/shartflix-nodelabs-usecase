import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/auth/domain/repositories/auth_repository.dart';
import 'package:shartflix/models/no_params.dart';

class LogoutUseCase implements UseCase<bool, NoParams> {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  @override
  Future<bool> call({NoParams? params}) {
    return _authRepository.logout();
  }
}
