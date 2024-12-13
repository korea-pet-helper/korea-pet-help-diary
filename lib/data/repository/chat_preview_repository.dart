import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:korea_pet_help_diary/data/model/chat_preview.dart';

class ChatPreviewRepository {
  /// 근처 지역 채팅방 가져오기
  Future<List<ChatPreview?>> getPreview(List<String> localsCode) async {
    try {
      // 1. 파이어스토어 인스턴스
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조
      final collectionRef = firestore.collection('Chats');
      // 3. 값 불러오기
      final result = await collectionRef.get();

      final docs = result.docs;

      return docs.map((doc) {
        for (var code in localsCode) {
          // 동네 코드가 맞는 chat 문서의 recentMessage 가져오기
          if (doc.id == code) {
            final recentMessage = doc.data()['recentMessage'];

            return ChatPreview.fronJson(recentMessage);
          }
        }
      }).toList();
    } catch (e) {
      print('getPreview => $e');
      return [];
    }
  }
}
