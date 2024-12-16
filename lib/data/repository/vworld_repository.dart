import 'package:dio/dio.dart';

class VworldRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: 'https://api.vworld.kr',
      validateStatus: (status) => true, // 실패 응답 시 에러 방지
    ),
  );

  Future<List<String>> findNearbyLocation(String localCode) async {
    try {
      // TODO: vworld 서버 터져서 임시로 return
      return ['28260122', '28260121', '28260122'];
      final response =
          await _client.get('/ned/data/damDongList', queryParameters: {
        'key': 'D9A81EA7-97D4-39DF-AC1A-4C62DB0D8C25',
        'admCode': localCode,
      });

      if (response.statusCode == 200) {
        //
      }
      return ['28260122', '28260122', '28260122'];
    } catch (e) {
      print('findNearbyLocation => $e');
      return [];
    }
  }
}
