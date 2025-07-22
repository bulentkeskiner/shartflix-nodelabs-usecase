import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/profile/domain/repositories/profile_repository.dart';
import 'package:shartflix/models/no_params.dart';
import 'package:shartflix/models/user_model.dart';

class GetProfileUseCase implements UseCase<Either<AppException, UserModel>, NoParams> {
  final ProfileRepository _profileRepository;

  GetProfileUseCase(this._profileRepository);

  @override
  Future<Either<AppException, UserModel>> call({NoParams? params}) {
    return _profileRepository.getProfile();
  }
}
