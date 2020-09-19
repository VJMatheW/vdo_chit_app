import 'package:permission_handler/permission_handler.dart';

abstract class PermissionServiceInterface {
  getPermission(String permission);
}

Map<String, Permission> map = {
  "contacts": Permission.contacts,
};

class PermissionService implements PermissionServiceInterface {
  @override
  Future<bool> getPermission(String perm) async {
    Permission permission = map[perm];
    PermissionStatus status = await permission.status;
    if (status != PermissionStatus.granted) {
      status = await permission.request();
      return status == PermissionStatus.granted;
    }
    return true;
  }
}
