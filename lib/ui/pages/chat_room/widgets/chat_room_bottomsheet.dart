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
        bottom: bottomPaddingSize,
      ),
      child: Row(
        children: [
          Expanded(
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
          )
        ],
      ),
    );
  }
}
