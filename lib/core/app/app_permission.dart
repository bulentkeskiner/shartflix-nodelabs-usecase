import 'package:permission_handler/permission_handler.dart';

class AppPermission {
  static AppPermission? _instance;
  static AppPermission get instance => _instance ??= AppPermission._init();

  AppPermission._init();

  Future<bool> requestPhotoPermission() async {
    var status = await Permission.photos.status;

    if (!status.isGranted) {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return false;
  }
}
