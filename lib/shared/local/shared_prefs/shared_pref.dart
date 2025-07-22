import 'package:shartflix/core/enum/shared_type.dart';

abstract class SharedPref {
  void init();

  bool get hasInitialized;

  Future<bool> remove(SharedType key);

  Future<Object?> get(SharedType key);

  Future<bool> set(SharedType key, String data);

  Future<void> clear();

  Future<bool> has(SharedType key);
}
