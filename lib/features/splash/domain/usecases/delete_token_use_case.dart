import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/splash/domain/repositories/splash_repository.dart';
import 'package:shartflix/models/no_params.dart';

class DeleteTokenUseCase implements UseCase<bool, NoParams> {
  final SplashRepository _splashRepository;

  DeleteTokenUseCase(this._splashRepository);

  @override
  Future<bool> call({NoParams? params}) {
    return _splashRepository.deleteUser();
  }
}
