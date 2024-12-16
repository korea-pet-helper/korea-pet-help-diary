import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/ui/pages/chat_room/chat_room_view_model.dart';
import 'package:korea_pet_help_diary/ui/pages/chat_room/widgets/chat_room_bottomsheet.dart';
import 'package:korea_pet_help_diary/ui/pages/chat_room/widgets/chat_room_receive.dart';
import 'package:korea_pet_help_diary/ui/pages/chat_room/widgets/chat_room_send.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  String chatRoomId;
  ChatRoomPage({required this.chatRoomId});

  @override
  ConsumerState<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  List<String> messages = [
    '안녕하세요 처음 뵙겠습니다!안녕하세요 처음 뵙겠습니다!',
    '강아지 키우고 있습니다',
    '네 안녕하세요!',
    '강아지가 너무 귀여워요',
    '감사합니다.',
  ];

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

    final state = ref.watch(chatRoomViewModelProvider);

    return GestureDetector(
      // 키보드 외 다른 곳 눌렀을 때 키보드 unfocus
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('용현동'),
        ),
        body: state?.isEmpty ?? true
            ? SizedBox()
            : ListView.separated(
                // 키보드 올렸을 때 마지막 채팅 보이게 bottom padding 설정
                padding: const EdgeInsets.only(bottom: 70),
                itemCount: state!.length,
                separatorBuilder: (context, index) => SizedBox(height: 2),
                itemBuilder: (context, index) {
                  final chat = state[index];
                  // 상대방
                  // TODO: 상대방과 나 구분짓는 코드 필요
                  if (index == 0) {
                    return ChatRoomReceive(
                        showProfile: true, message: chat.message);
                  } else if (index == 1) {
                    return ChatRoomReceive(
                        showProfile: false, message: chat.message);
                  } else if (index == 4) {
                    return ChatRoomReceive(
                        showProfile: true, message: chat.message);
                  }

                  // 나
                  return ChatRoomSend(message: chat.message);
                },
              ),
        bottomSheet: ChatRoomBottomsheet(controller, bottomPaddingSize),
      ),
    );
  }
}
