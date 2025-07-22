import 'package:shartflix/features/splash/data/datasources/splash_remote_data_source.dart';
import 'package:shartflix/features/splash/domain/repositories/splash_repository.dart';
import 'package:shartflix/models/user_model.dart';

class SplashRepositoryImpl extends SplashRepository {
  final SplashRemoteDataSource _splashRemoteDataSource;

  SplashRepositoryImpl(this._splashRemoteDataSource);

  @override
  Future<bool> hasToken() async {
    return _splashRemoteDataSource.hasToken();
  }

  @override
  Future<bool> deleteUser() {
    return _splashRemoteDataSource.deleteUser();
  }

  @override
  Future<String?> getToken() async {
    return _splashRemoteDataSource.getToken();
  }

  @override
  Future<UserModel?> getUser() {
    return _splashRemoteDataSource.getUser();
  }

  @override
  Future<bool> saveUser(UserModel model) {
    return _splashRemoteDataSource.saveUser(model);
  }
}
