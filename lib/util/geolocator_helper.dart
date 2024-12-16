import 'package:geolocator/geolocator.dart';
import 'vworld_repository.dart';

class GeolocatorHelper {
  static bool isDenied(LocationPermission permission) {
    return permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever;
  }

  // 위치 권한 확인
  static Future<LocationPermission> checkPermission() async {
    final permission = await Geolocator.checkPermission();
    if (isDenied(permission)) {
      final request = await Geolocator.requestPermission();
      return request;
    }
    return permission;
  }

  // 현재 위치 가져오기
  static Future<Position?> getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print("Error in getting current position: $e");
      return null;
    }
  }

  // VWorldRepository를 통해 행정구역 데이터 가져오기
  static Future<Map<String, dynamic>?> getAreaFromCoordinates(
      double lat, double lng) async {
    final vworldRepository = VworldRepository();
    try {
      final areas = await vworldRepository.findByLatLng(lat: lat, lng: lng);
      if (areas.isNotEmpty) {
        final area = areas.first;
        return {'name': area['full_nm'], 'code': area['emd_cd']};
      }
    } catch (e) {
      print("Error in fetching area data: $e");
    }
    return null;
  }

  // 행정구역 정보 가져오기
  static Future<Map<String, dynamic>?> getAdministrativeArea() async {
    // 위치 권한 확인 및 요청
    final permission = await checkPermission();
    if (isDenied(permission)) {
      return null; // 권한이 없으면 null 반환
    }

    // 현재 위치 가져오기
    final position = await getCurrentPosition();
    if (position == null) {
      return null; // 위치 정보가 없으면 null 반환
    }

    // 좌표를 이용해 행정구역 데이터 가져오기
    return await getAreaFromCoordinates(position.latitude, position.longitude);
  }
}
