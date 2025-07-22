import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/features/discover/domain/entities/movie_response.dart';
import 'package:shartflix/features/discover/domain/entities/toggle_favorite_response.dart';

abstract class DiscoverRemoteDataSource {
  Future<Either<AppException, MovieResponse>> list({required int page});

  Future<Either<AppException, ToggleFavoriteResponse>> toggleFavorite({
    required String id,
  });
}
