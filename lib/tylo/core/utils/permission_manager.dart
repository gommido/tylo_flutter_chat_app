import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<PermissionStatus> getPermission(Permission permission) async {
    PermissionStatus permissionStatus = await permission.status;

    if (permissionStatus != PermissionStatus.granted
        && permissionStatus != PermissionStatus.permanentlyDenied
        || permissionStatus == PermissionStatus.denied) {
      permissionStatus = await permission.request();
    }
    return permissionStatus;

  }

  Future<void> openPhoneSettingApp() async {
    await openAppSettings();
  }
}


