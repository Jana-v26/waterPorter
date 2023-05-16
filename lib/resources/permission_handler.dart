


class PermissionService{
  final PermissionService _permissionHandler = PermissionService();

  // Future<bool> _requestPermission(PermissionService permission) async {
  //   var result = await _permissionHandler._requestPermission(permission);
  //   if (result == PermissionStatus.granted) {
  //     return true;
  //   }
  //   return false;
  // }

  // Future<bool> requestPermission({Function onPermissionDenied}) async {
  //   var granted = await _requestPermission();
  //   if (!granted) {
  //     onPermissionDenied();
  //   }
  //   return granted;
  // }
  //
  // Future<bool> hasPhonePermission() async {
  //   return hasPermission(PermissionGroup.phone);
  // }
  //
  // Future<bool> hasPermission(PermissionGroup permission) async {
  //   var permissionStatus =
  //   await _permissionHandler.checkPermissionStatus(permission);
  //   return permissionStatus == PermissionStatus.granted;
  // }
}