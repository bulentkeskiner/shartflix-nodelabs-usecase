import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shartflix/core/enum/shared_type.dart';
import 'package:shartflix/shared/local/shared_prefs/shared_pref.dart';

class SecureShraredPrefImpl extends SharedPref {
  FlutterSecureStorage? sharedPreferences;
  final Completer<FlutterSecureStorage> initCompleter = Completer<FlutterSecureStorage>();

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  @override
  Future<void> clear() async {
    sharedPreferences = await initCompleter.future;
    await sharedPreferences!.deleteAll();
  }

  @override
  Future<Object?> get(SharedType key) async {
    sharedPreferences = await initCompleter.future;
    return sharedPreferences!.read(key: key.name);
  }

  @override
  Future<bool> has(SharedType key) async {
    sharedPreferences = await initCompleter.future;
    return sharedPreferences?.containsKey(key: key.name) ?? false;
  }

  @override
  bool get hasInitialized => sharedPreferences != null;

  @override
  void init() {
    initCompleter.complete(FlutterSecureStorage(aOptions: _getAndroidOptions()));
  }

  @override
  Future<bool> remove(SharedType key) async {
    sharedPreferences = await initCompleter.future;
    await sharedPreferences!.delete(key: key.name);
    return true;
  }

  @override
  Future<bool> set(SharedType key, String data) async {
    sharedPreferences = await initCompleter.future;
    await sharedPreferences!.write(key: key.name, value: data.toString());
    return true;
  }
}
