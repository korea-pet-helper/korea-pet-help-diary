import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:korea_pet_help_diary/data/model/chat.dart';

class ChatRepository {
  /// 메시지 보내기
  Future<void> sendMessage(Chat chat, String local) async {
    try {
      final firestore = FirebaseFirestore.instance;

      final docRef = firestore.collection('Chats').doc(chat.chatRoomId);

      await docRef.update({
        'message': FieldValue.arrayUnion([chat.toJson()]),
        'recentMessage': {
          'chatRoomId': chat.chatRoomId,
          'local': local,
          'message': chat.message,
          'thumbnail': chat.userImage,
          'timeStamp': chat.timeStamp.toIso8601String(),
        }
      }).then(
        (value) => chat.toJson(),
      );
    } catch (e) {
      print('sendMessage => $e');
    }
  }

  /// 실시간으로 데이터 가져오기
  Stream<List<Chat>?> snapshotChatList(String chatRoomId) {
    try {
      final firestore = FirebaseFirestore.instance;

      final doc = firestore.collection('Chats').doc(chatRoomId);

      return doc.snapshots().map((snapshot) {
        List<Chat> result = [];

        final messages = List.from(snapshot.data()!['message']);

        for (var message in messages) {
          result.add(Chat.fromJson(message));
        }

        return result;
      });
    } catch (e) {
      print('getRealTimeChatList $e');
      return const Stream.empty();
    }
  }
}
