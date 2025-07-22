import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/splash/domain/repositories/splash_repository.dart';
import 'package:shartflix/models/no_params.dart';

class GetTokenUseCase implements UseCase<String?, NoParams> {
  final SplashRepository _splashRepository;

  GetTokenUseCase(this._splashRepository);

  @override
  Future<String?> call({NoParams? params}) {
    return _splashRepository.getToken();
  }
}
