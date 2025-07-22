import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/core/network/end_points.dart';
import 'package:shartflix/core/network/network_service.dart';
import 'package:shartflix/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:shartflix/models/movie_model.dart';
import 'package:shartflix/models/user_model.dart';

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final NetworkService _service;

  ProfileRemoteDataSourceImpl(this._service);

  @override
  Future<Either<AppException, List<MovieModel>>> getFavoriteMovies() async {
    final response = await _service.get(EndPoints.movieFavorites());

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: EndPoints.movieFavorites(),
            message: 'The data is not in the valid format',
            statusCode: 0,
          ),
        );
      } else {
        return Right((jsonData as List).map((e) => MovieModel.fromJson(e)).toList());
      }
    });
  }

  @override
  Future<Either<AppException, UserModel>> getProfile() async {
    final response = await _service.get(EndPoints.userProfile());

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: EndPoints.userProfile(),
            message: 'The data is not in the valid format',
            statusCode: 0,
          ),
        );
      } else {
        return Right(UserModel.fromJson(jsonData));
      }
    });
  }

  @override
  Future<Either<AppException, UserModel>> uploadPhoto(File file) async {
    final formData = FormData.fromMap({
      Params.file: await MultipartFile.fromFile(file.path, filename: basename(file.path)),
    });
    final response = await _service.post(EndPoints.userUploadPhoto(), data: formData);

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: EndPoints.userUploadPhoto(),
            message: 'The data is not in the valid format',
            statusCode: 0,
          ),
        );
      } else {
        return Right(UserModel.fromJson(jsonData));
      }
    });
  }
}
