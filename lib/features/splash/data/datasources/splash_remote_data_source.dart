import 'package:shartflix/models/user_model.dart';

abstract class SplashRemoteDataSource {
  Future<bool> hasToken();

  Future<String?> getToken();

  Future<bool> deleteUser();

  Future<bool> saveUser(UserModel model);

  Future<UserModel?> getUser();
}
