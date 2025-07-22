import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/profile/domain/repositories/profile_repository.dart';
import 'package:shartflix/models/movie_model.dart';
import 'package:shartflix/models/no_params.dart';

class GetMyFavoriteUseCase
    extends UseCase<Either<AppException, List<MovieModel>>, NoParams> {
  final ProfileRepository _profileRepository;

  GetMyFavoriteUseCase(this._profileRepository);

  @override
  Future<Either<AppException, List<MovieModel>>> call({NoParams? params}) {
    return _profileRepository.getFavoriteMovies();
  }
}
