import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/data/model/chat_preview.dart';
import 'package:korea_pet_help_diary/data/repository/chat_preview_repository.dart';
import 'package:korea_pet_help_diary/data/repository/vworld_repository.dart';

class HomeViewModel extends FamilyNotifier<List<ChatPreview?>, String> {
  @override
  List<ChatPreview> build(String arg) {
    fetchChatPreivew();
    return [];
  }

  /// 채팅 목록 가져오기
  Future<void> fetchChatPreivew() async {
    final vworldRepo = VworldRepository();
    final result = await vworldRepo.findNearbyLocation(arg);

    final chatPrevierRepo = ChatPreviewRepository();
    state = await chatPrevierRepo.getPreview(result);
  }
}

final homeViewModelProvider =
    NotifierProvider.family<HomeViewModel, List<ChatPreview?>, String>(() {
  return HomeViewModel();
});
