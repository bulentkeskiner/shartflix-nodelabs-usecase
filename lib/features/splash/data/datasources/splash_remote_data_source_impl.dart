import 'dart:convert';

import 'package:shartflix/core/enum/shared_type.dart';
import 'package:shartflix/features/splash/data/datasources/splash_remote_data_source.dart';
import 'package:shartflix/models/user_model.dart';
import 'package:shartflix/shared/local/shared_prefs/shared_pref.dart';

class SplashRemoteDataSourceImpl extends SplashRemoteDataSource {
  final SharedPref _sharedPref;

  SplashRemoteDataSourceImpl(this._sharedPref);

  @override
  Future<bool> hasToken() async {
    var user = await getUser();
    var token = user?.token;
    return token != null && token.isNotEmpty;
  }

  @override
  Future<bool> deleteUser() {
    return _sharedPref.remove(SharedType.userModel);
  }

  @override
  Future<String?> getToken() async {
    var user = await getUser();
    var token = user?.token;

    if (token is String) return token;
    return null;
  }

  @override
  Future<UserModel?> getUser() async {
    final userJson = await _sharedPref.get(SharedType.userModel);
    if (userJson == null || userJson is! String) return null;
    final Map<String, dynamic> jsonMap = json.decode(userJson);
    return UserModel.fromJson(jsonMap);
  }

  @override
  Future<bool> saveUser(UserModel model) async {
    final userJson = json.encode(model.toJson());
    return _sharedPref.set(SharedType.userModel, userJson);
  }
}
