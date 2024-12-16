import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/data/model/chat.dart';
import 'package:korea_pet_help_diary/data/repository/chat_repository.dart';

class ChatRoomViewModel extends Notifier<List<Chat>?> {
  @override
  List<Chat> build() {
    fetch();
    return [];
  }

  Future<List<Chat>?> getChatList(String chatRoomId) async {
    final chatRepo = ChatRepository();
    final result = await chatRepo.getChatList(chatRoomId);
    state = result;
  }

  void fetch() {
    getChatList('28260122');
  }
}

final chatRoomViewModelProvider =
    NotifierProvider<ChatRoomViewModel, List<Chat>?>(
  () {
    return ChatRoomViewModel();
  },
);
