import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shartflix/core/enum/shared_type.dart';
import 'package:shartflix/shared/local/shared_prefs/shared_pref.dart';

class SharedPrefImplementation implements SharedPref {
  SharedPreferences? sharedPreferences;

  final Completer<SharedPreferences> initCompleter = Completer<SharedPreferences>();

  SharedPrefImplementation() {
    init();
  }

  @override
  void init() {
    initCompleter.complete(SharedPreferences.getInstance());
  }

  @override
  bool get hasInitialized => sharedPreferences != null;

  @override
  Future<bool> set(SharedType key, String data) async {
    sharedPreferences = await initCompleter.future;
    return await sharedPreferences!.setString(key.name, data.toString());
  }

  @override
  Future<Object?> get(SharedType key) async {
    sharedPreferences = await initCompleter.future;
    return sharedPreferences!.get(key.name);
  }

  @override
  Future<bool> has(SharedType key) async {
    sharedPreferences = await initCompleter.future;
    return sharedPreferences?.containsKey(key.name) ?? false;
  }

  @override
  Future<bool> remove(SharedType key) async {
    sharedPreferences = await initCompleter.future;
    return await sharedPreferences!.remove(key.name);
  }

  @override
  Future<void> clear() async {
    sharedPreferences = await initCompleter.future;
    await sharedPreferences!.clear();
  }
}
