import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/data/model/chat.dart';
import 'package:korea_pet_help_diary/data/model/chat_preview.dart';
import 'package:korea_pet_help_diary/data/model/user.dart';
import 'package:korea_pet_help_diary/ui/pages/chat_room/chat_room_view_model.dart';

class ChatRoomBottomsheet extends StatelessWidget {
  // 2a52be
  static const ceruleanBlue = Color.fromARGB(255, 42, 82, 190);

  TextEditingController controller;
  double bottomPaddingSize;
  ChatPreview preview;
  User user;
  ChatRoomBottomsheet({
    required this.controller,
    required this.bottomPaddingSize,
    required this.preview,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final vm = ref.watch(chatRoomViewModelProvider.notifier);

      return Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 20,
          right: 20,
          // padding + top 에 준 값까지 -> 키보드 올리면 키보드랑 TextField 랑 붙어보이는 거 때문
          bottom: bottomPaddingSize + 10,
        ),
        child: Row(
          children: [
            Expanded(
              // TODO: send 눌렀을 때 키보드 없어지는 문제 확인하기...
              // 메시지 보내는 거
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                // 아무것도 없는 내용 보내지 않도록 하기
                if (controller.text.trim().isNotEmpty) {
                  Chat chat = Chat(
                      chatRoomId: preview.chatRoomId,
                      message: controller.text,
                      nickname: user.nickname,
                      userId: user.userId,
                      timeStamp: DateTime.now(),
                      userImage: user.image);

                  // 메시지 전달
                  vm.sendChat(chat, preview.local);

                  // 메시지 보내고 controller 에서 지우기
                  controller.text = '';
                }
              },
              // 보내는 아이콘
              child: Container(
                height: 50,
                width: 50,
                color: Colors.transparent,
                child: const Icon(
                  Icons.send,
                  size: 30,
                  color: ceruleanBlue,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
