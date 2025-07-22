import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shartflix/core/exceptions/app_exception.dart';
import 'package:shartflix/features/profile/domain/repositories/profile_repository.dart';
import 'package:shartflix/models/user_model.dart';

class UploadProfilePhotoUseCase {
  final ProfileRepository repository;
  UploadProfilePhotoUseCase(this.repository);

  Future<Either<AppException, UserModel>> call(File photo) {
    return repository.uploadPhoto(photo);
  }
}
