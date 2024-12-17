import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:korea_pet_help_diary/data/model/chat_preview.dart';
import 'package:korea_pet_help_diary/data/model/user.dart';

class ChatPreviewRepository {
  // 참여했던 채팅방 목록 가져오기
  Future<List<ChatPreview>?> getPreview(List<String> localsCode) async {
    try {
      // 1. 파이어스토어 인스턴스
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조
      final collectionRef = firestore.collection('Chats');
      // 3. 값 불러오기
      final result = await collectionRef.get();

      final docs = result.docs;

      List<ChatPreview>? list = [];

      docs.forEach((doc) {
        for (var code in localsCode) {
          // 동네 코드가 맞는 chat 문서의 recentMessage 가져오기
          if (doc.id == code) {
            final recentMessage = doc.data()['recentMessage'];

            list.add(ChatPreview.fronJson(recentMessage));
          }
        }
      });

      return list;
    } catch (e) {
      print('getPreview => $e');
      return [];
    }
  }

  /// 나의 지역 채팅방 가져오기
  Future<ChatPreview?> getMyChatPreview(User user) async {
    try {
      // 1. 파이어스토어 인스턴스
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조
      final collectionRef = firestore.collection('Chats').doc(user.localCode);
      // 3. 값 불러오기
      final result = await collectionRef.get();

      if (result.exists) {
        return ChatPreview.fronJson(result.data()!['recentMessage']);
      } else {
        // 채팅방 없으면 새로 만들기
        createChatRoom(user);
        return ChatPreview.fronJson(result.data()!['recentMessage']);
      }
    } catch (e) {
      print('getPreview => $e');
      return null;
    }
  }

  /// 새로운 채팅방 생성
  Future<void> createChatRoom(User user) async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('Chats').doc(user.localCode).set({
      'chatRoomId': user.localCode,
      'message': [],
      'recentMessage': {
        'chatRoomId': user.localCode,
        'local': user.local,
        'message': '',
        'thumbnail':
            'https://github.com/korea-pet-helper/korea-pet-help-diary/blob/master/assets/images/welcome.png',
        'timeStamp': DateTime.now().toIso8601String(),
      }
    });
  }
}
