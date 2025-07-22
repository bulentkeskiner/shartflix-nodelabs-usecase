import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/network/end_points.dart';
import 'package:shartflix/core/network/network_service.dart';
import 'package:shartflix/features/discover/data/datasources/discover_remote_data_source.dart';
import 'package:shartflix/features/discover/domain/entities/movie_response.dart';
import 'package:shartflix/features/discover/domain/entities/toggle_favorite_response.dart';

class DiscoverRemoteDataSourceImpl extends DiscoverRemoteDataSource {
  final NetworkService _service;

  DiscoverRemoteDataSourceImpl(this._service);

  @override
  Future<Either<AppException, MovieResponse>> list({required int page}) async {
    final response = await _service.get(EndPoints.movieList(page));

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: EndPoints.movieList(page),
            message: 'The data is not in the valid format',
            statusCode: 0,
          ),
        );
      } else {
        return Right(MovieResponse.fromJson(jsonData));
      }
    });
  }

  @override
  Future<Either<AppException, ToggleFavoriteResponse>> toggleFavorite({
    required String id,
  }) async {
    final response = await _service.post(EndPoints.movieFavorite(id));

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: EndPoints.movieFavorite(id),
            message: 'The data is not in the valid format',
            statusCode: 0,
          ),
        );
      } else {
        return Right(ToggleFavoriteResponse.fromJson(jsonData));
      }
    });
  }
}
