import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/features/discover/data/datasources/discover_remote_data_source.dart';
import 'package:shartflix/features/discover/domain/entities/movie_response.dart';
import 'package:shartflix/features/discover/domain/entities/toggle_favorite_response.dart';
import 'package:shartflix/features/discover/domain/repositories/discover_repository.dart';

class DiscoverRepositoryImpl extends DiscoverRepository {
  final DiscoverRemoteDataSource _discoverRemoteDataSource;

  DiscoverRepositoryImpl(this._discoverRemoteDataSource);

  @override
  Future<Either<AppException, MovieResponse>> list({required int page}) {
    return _discoverRemoteDataSource.list(page: page);
  }

  @override
  Future<Either<AppException, ToggleFavoriteResponse>> toggleFavorite({
    required String id,
  }) {
    return _discoverRemoteDataSource.toggleFavorite(id: id);
  }
}
