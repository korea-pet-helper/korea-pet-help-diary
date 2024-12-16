import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/data/model/chat.dart';
import 'package:korea_pet_help_diary/data/model/chat_preview.dart';
import 'package:korea_pet_help_diary/data/model/user.dart';
import 'package:korea_pet_help_diary/ui/pages/chat_room/chat_room_view_model.dart';
import 'package:korea_pet_help_diary/ui/pages/chat_room/widgets/chat_room_bottomsheet.dart';
import 'package:korea_pet_help_diary/ui/pages/chat_room/widgets/chat_room_receive.dart';
import 'package:korea_pet_help_diary/ui/pages/chat_room/widgets/chat_room_send.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  ChatPreview preview;
  User user;
  ChatRoomPage({required this.preview, required this.user});

  @override
  ConsumerState<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 아이폰 언더바 같은 부분 padding 값
    final bottomPaddingSize = MediaQuery.paddingOf(context).bottom;

    final vm = ref.watch(chatRoomViewModelProvider.notifier);

    return GestureDetector(
      // 키보드 외 다른 곳 눌렀을 때 키보드 unfocus
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.preview.local),
        ),
        body: StreamBuilder<List<Chat>?>(
          stream: vm.snapshotChatList(widget.preview.chatRoomId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // 데이터가 없을 때
              return const Center(
                child: Text(
                  '채팅방이 개설되었습니다. 첫 채팅을 남겨주세요!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              // snapshot 오류 발생
              return const Center(
                child: Text('오류가 발생했습니다.'),
              );
            } else {
              List<Chat>? data = snapshot.data;

              return ListView.separated(
                // 키보드 올렸을 때 마지막 채팅 보이게 bottom padding 설정
                padding: const EdgeInsets.only(bottom: 70),
                itemCount: data!.length,
                separatorBuilder: (context, index) => SizedBox(height: 2),
                itemBuilder: (context, index) {
                  final chat = data[index];
                  // 채팅 정보의 userId 와 로그인한 유저 정보가 같으면 send
                  if (chat.userId == widget.user.userId) {
                    return ChatRoomSend(chat: chat);
                  } else {
                    // 상대방
                    bool showProfile = true;
                    if (index > 0) {
                      final pastChat = data[index - 1];
                      showProfile = isShowProfile(pastChat, chat);
                    }
                    return ChatRoomReceive(
                        showProfile: showProfile, chat: chat);
                  }
                },
              );
            }
          },
        ),
        bottomSheet: ChatRoomBottomsheet(
          controller: controller,
          bottomPaddingSize: bottomPaddingSize,
          preview: widget.preview,
          user: widget.user,
        ),
      ),
    );
  }

  /// 프로필 보여줄지 말지 확인용
  /// ture: 프로필 O, false: 프로필 X
  bool isShowProfile(Chat pastChat, Chat presentChat) {
    // 지난 채팅의 userId 와 현재 채팅의 userId 가 다르면 true
    if (pastChat.userId != presentChat.userId) {
      return true;
    } else if (presentChat.timeStamp.difference(pastChat.timeStamp).inSeconds >
            60 ||
        pastChat.timeStamp.minute != presentChat.timeStamp.minute) {
      // 지난 채팅 시간과 현재 채팅 시간이 1분 이상 차이나면 true
      return true;
    } else {
      return false;
    }
  }
}
