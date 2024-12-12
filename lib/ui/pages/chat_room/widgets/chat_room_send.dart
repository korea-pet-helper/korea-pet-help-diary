import 'package:flutter/material.dart';

class ChatRoomSend extends StatelessWidget {
  String message;
  ChatRoomSend({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 시간
          Text(
            '1분전',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 5),
          // 메시지
          Container(
            // TODO: 메시지 길이에 따라 container 사이즈 조절 필요
            height: 80,
            width: 280,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              softWrap: true,
              message,
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
