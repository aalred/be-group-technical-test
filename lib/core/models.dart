import 'package:location/location.dart';

class MyLocation {
  final Location _location = new Location();
  late PermissionStatus _permissionGranted;
  late LocationData locationData;
  double _latitude = 0;
  double _longitude = 0;

  Future<bool> getPermissions() async {
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        _location.requestService();
        return false;
      }
    }
    return true;
  }

  Future<String> getLocation() async {
    try {
      
      locationData = await _location.getLocation();
      _latitude = locationData.latitude ?? _latitude;
      _longitude = locationData.longitude ?? _longitude;
      return "lat:${_latitude}, long:${_longitude}";
    } catch (e) {
      return "Permisos no proporcionados";
    }
  }
}
