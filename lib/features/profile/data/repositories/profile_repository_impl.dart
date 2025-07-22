import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:shartflix/features/profile/domain/repositories/profile_repository.dart';
import 'package:shartflix/models/movie_model.dart';
import 'package:shartflix/models/user_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;

  ProfileRepositoryImpl(this._profileRemoteDataSource);
  @override
  Future<Either<AppException, UserModel>> getProfile() async {
    return _profileRemoteDataSource.getProfile();
  }

  @override
  Future<Either<AppException, List<MovieModel>>> getFavoriteMovies() async {
    return _profileRemoteDataSource.getFavoriteMovies();
  }

  @override
  Future<Either<AppException, UserModel>> uploadPhoto(File file) {
    return _profileRemoteDataSource.uploadPhoto(file);
  }
}
