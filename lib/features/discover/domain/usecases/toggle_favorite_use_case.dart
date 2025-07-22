import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/discover/domain/entities/toggle_favorite_response.dart';
import 'package:shartflix/features/discover/domain/repositories/discover_repository.dart';

class ToggleFavoriteUseCase
    implements UseCase<Either<AppException, ToggleFavoriteResponse>, String> {
  final DiscoverRepository _discoverRepository;

  ToggleFavoriteUseCase(this._discoverRepository);

  @override
  Future<Either<AppException, ToggleFavoriteResponse>> call({required String params}) {
    return _discoverRepository.toggleFavorite(id: params);
  }
}
