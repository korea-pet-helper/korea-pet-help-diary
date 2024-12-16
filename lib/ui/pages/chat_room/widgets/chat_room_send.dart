import 'package:flutter/material.dart';
import 'package:korea_pet_help_diary/data/model/chat.dart';
import 'package:korea_pet_help_diary/util/date_time_format.dart';

class ChatRoomSend extends StatelessWidget {
  Chat chat;
  ChatRoomSend({required this.chat});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width - 180;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 시간
          Text(
            DateTimeFormat.formatChatTime(chat.timeStamp),
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 5),
          // 메시지
          Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              softWrap: true,
              chat.message,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
