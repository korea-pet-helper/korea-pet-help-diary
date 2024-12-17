import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/data/model/chat.dart';
import 'package:korea_pet_help_diary/data/repository/chat_repository.dart';
import 'package:korea_pet_help_diary/data/repository/user_repository.dart';

class ChatRoomViewModel extends Notifier<List<Chat>?> {
  @override
  List<Chat> build() {
    return [];
  }

  final chatRepo = ChatRepository();

  Future<void> sendChat(Chat chat, String local) async {
    await chatRepo.sendMessage(chat, local);

    final userRepo = UserRepository();
    await userRepo.updateChatRoomIds(chat.userId, chat.chatRoomId);
  }

  Stream<List<Chat>?> snapshotChatList(String chatRoomId) {
    return chatRepo.snapshotChatList(chatRoomId);
  }
}

final chatRoomViewModelProvider =
    NotifierProvider<ChatRoomViewModel, List<Chat>?>(
  () {
    return ChatRoomViewModel();
  },
);
