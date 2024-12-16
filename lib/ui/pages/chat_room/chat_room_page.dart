import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/data/model/chat.dart';
import 'package:korea_pet_help_diary/data/repository/chat_repository.dart';
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

    final vm = ref.watch(chatRoomViewModelProvider.notifier);

    return GestureDetector(
      // 키보드 외 다른 곳 눌렀을 때 키보드 unfocus
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('용현동'),
        ),
        body: StreamBuilder<List<Chat>?>(
          stream: vm.snapshotChatList('28260122'),
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
                  // 상대방
                  // TODO: 상대방과 나 구분짓는 코드 필요
                  if (index == 0) {
                    return ChatRoomReceive(showProfile: true, chat: chat);
                  } else if (index == 1) {
                    return ChatRoomReceive(showProfile: false, chat: chat);
                  } else if (index == 4) {
                    return ChatRoomReceive(showProfile: true, chat: chat);
                  }

                  // 나
                  return ChatRoomSend(chat: chat);
                },
              );
            }
          },
        ),
        bottomSheet: ChatRoomBottomsheet(controller, bottomPaddingSize),
      ),
    );
  }
}
