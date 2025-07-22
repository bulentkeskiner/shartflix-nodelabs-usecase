import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/models/movie_model.dart';
import 'package:shartflix/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<AppException, UserModel>> getProfile();

  Future<Either<AppException, UserModel>> uploadPhoto(File file);

  Future<Either<AppException, List<MovieModel>>> getFavoriteMovies();
}
