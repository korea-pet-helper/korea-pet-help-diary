import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/data/model/chat_preview.dart';
import 'package:korea_pet_help_diary/data/model/user.dart';
import 'package:korea_pet_help_diary/data/repository/chat_preview_repository.dart';

class HomeState {
  ChatPreview? chatPreview;
  List<ChatPreview>? chatPreviewList;

  HomeState({required this.chatPreview, required this.chatPreviewList});

  HomeState copy({
    ChatPreview? chatPreview,
    required List<ChatPreview> chatPreviewList,
  }) {
    return HomeState(
      chatPreview: chatPreview ?? this.chatPreview,
      chatPreviewList: chatPreviewList,
    );
  }
}

class HomeViewModel extends FamilyNotifier<HomeState, User> {
  @override
  HomeState build(User arg) {
    fetchChatPreivew();
    return HomeState(chatPreview: null, chatPreviewList: []);
  }

  final chatPreviewRepo = ChatPreviewRepository();

  Future<ChatPreview?> getMyChatPreview(User user) async {
    final chatPreview = await chatPreviewRepo.getMyChatPreview(user);
    return chatPreview;
  }

  Future<void> fetchChatPreivew() async {
    final myChatPreview = await getMyChatPreview(arg);
    final chatPreviewList = await chatPreviewRepo.getPreview(arg.chatRoomIds);

    state = HomeState(
        chatPreview: myChatPreview, chatPreviewList: chatPreviewList!);
  }
}

final homeViewModelProvider =
    NotifierProvider.family<HomeViewModel, HomeState, User>(() {
  return HomeViewModel();
});
