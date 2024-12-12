import 'package:flutter/material.dart';

class ChatRoomBottomsheet extends StatelessWidget {
  // 2a52be
  static const ceruleanBlue = Color.fromARGB(255, 42, 82, 190);

  TextEditingController controller;
  double bottomPaddingSize;
  ChatRoomBottomsheet(this.controller, this.bottomPaddingSize);

  @override
  Widget build(BuildContext context) {
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
              // 메시지 전달
              print('메시지 전달');
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
  }
}
