import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/splash/domain/repositories/splash_repository.dart';
import 'package:shartflix/models/no_params.dart';

class CheckTokenUseCase implements UseCase<bool, NoParams> {
  final SplashRepository _splashRepository;

  CheckTokenUseCase(this._splashRepository);

  @override
  Future<bool> call({required NoParams params}) {
    return _splashRepository.hasToken();
  }
}
