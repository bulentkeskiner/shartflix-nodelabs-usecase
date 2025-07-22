import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/splash/domain/repositories/splash_repository.dart';
import 'package:shartflix/models/user_model.dart';

class SaveUserUseCase implements UseCase<bool, UserModel> {
  final SplashRepository _splashRepository;

  SaveUserUseCase(this._splashRepository);

  @override
  Future<bool> call({required UserModel params}) {
    return _splashRepository.saveUser(params);
  }
}
