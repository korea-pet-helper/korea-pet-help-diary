import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:korea_pet_help_diary/data/model/chat.dart';

class ChatRepository {
  /// 채팅 목록 가져오기
  Future<List<Chat>?> getChatList(String chatRoomId) async {
    try {
      final firestore = FirebaseFirestore.instance;

      final collectionRef = firestore.collection('Chats');

      final result = await collectionRef.get();

      final docs = result.docs;

      List<Chat>? chatList = [];

      for (var doc in docs) {
        if (doc.id == chatRoomId) {
          final messageList = List.from(doc.data()['message']);

          for (var message in messageList) {
            chatList.add(Chat.fromJson(message));
          }
          break;
        }
      }

      return chatList;
    } catch (e) {
      print('getChatList => $e');
      return [];
    }
  }

  /// 메시지 보내기
  Future<void> sendMessage(Chat chat) async {
    try {
      final firestore = FirebaseFirestore.instance;

      final docRef = firestore.collection('Chats').doc(chat.chatRoomId);

      await docRef.update({
        'message': FieldValue.arrayUnion([chat.toJson()])
      }).then(
        (value) => chat.toJson(),
      );
    } catch (e) {
      print('sendMessage => $e');
    }
  }
}
