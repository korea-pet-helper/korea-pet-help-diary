import 'package:dio/dio.dart';

class VworldRepository {
  final Dio _client = Dio(BaseOptions(
    // 설정안할 시 실패 응답 시 throw
    validateStatus: (status) => true,
  ));

  /// Query에 해당하는 첫 번째 `title`을 반환하는 함수
  Future<String> findTitle(String query) async {
    final response = await _client.get(
      'https://api.vworld.kr/req/search',
      queryParameters: {
        'request': 'search',
        'key': 'D9A81EA7-97D4-39DF-AC1A-4C62DB0D8C25',
        'query': query,
        'type': 'DISTRICT',
        'category': 'L4',
      },
    );

    if (response.statusCode == 200 &&
        response.data['response']['status'] == 'OK') {
      // `items` 리스트에서 첫 번째 `title`을 반환
      final items = List.of(response.data['response']['result']['items']);
      if (items.isNotEmpty) {
        return items.first['title'].toString(); // 첫 번째 `title`
      }
    }

    // 결과가 없거나 오류 발생 시 빈 문자열 반환
    return '';
  }

  //gps 좌표로 행정구역 가져오기
  Future<List<Map<String, String>>> findByLatLng({
    required double lat,
    required double lng,
  }) async {
    final response = await _client.get(
      'https://api.vworld.kr/req/data',
      queryParameters: {
        'request': 'GetFeature',
        'data': 'LT_C_ADEMD_INFO',
        'key': 'D9A81EA7-97D4-39DF-AC1A-4C62DB0D8C25',
        'geomfilter': 'point($lng $lat)',
        'geometry': 'false',
      },
    );

    if (response.statusCode == 200 &&
        response.data['response']['status'] == 'OK') {
      return List.of(response.data['response']['result']['featureCollection']
              ['features'])
          .map((e) => {
                'full_nm': e['properties']['full_nm'].toString(),
                'emd_cd': e['properties']['emd_cd'].toString(),
              })
          .toList();
    }

    return [];
  }
}
