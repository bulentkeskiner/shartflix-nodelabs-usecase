import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/discover/domain/entities/movie_response.dart';
import 'package:shartflix/features/discover/domain/repositories/discover_repository.dart';

class GetMovieListUseCase implements UseCase<Either<AppException, MovieResponse>, int> {
  final DiscoverRepository _discoverRepository;

  GetMovieListUseCase(this._discoverRepository);

  @override
  Future<Either<AppException, MovieResponse>> call({required int params}) {
    return _discoverRepository.list(page: params);
  }
}
