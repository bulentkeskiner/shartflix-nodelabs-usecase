import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/splash/domain/repositories/splash_repository.dart';
import 'package:shartflix/models/no_params.dart';
import 'package:shartflix/models/user_model.dart';

class GetUserUseCase implements UseCase<UserModel?, NoParams> {
  final SplashRepository _splashRepository;

  GetUserUseCase(this._splashRepository);

  @override
  Future<UserModel?> call({NoParams? params}) {
    return _splashRepository.getUser();
  }
}
