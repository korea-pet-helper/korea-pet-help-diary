import 'package:dio/dio.dart';

class VworldRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: 'https://api.vworld.kr',
      validateStatus: (status) => true, // 실패 응답 시 에러 방지
    ),
  );

  Future<List<Map<String, String>>> findByLatLng({
    required double lat,
    required double lng,
  }) async {
    final response = await _client.get(
      '/req/data',
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
                'full_nm': e['properties']['full_nm'].toString(), //행정구역명
                'emd_cd': e['properties']['emd_cd'].toString(), //로컬코드
              })
          .toList();
    }

    return [];
  }
}
