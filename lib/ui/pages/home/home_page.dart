import 'package:flutter/material.dart';
import 'package:korea_pet_help_diary/ui/pages/chat_room/chat_room_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('삼성동'),
        actions: [
          GestureDetector(
            onTap: () {
              // TODO: myProfile 페이지로 이동
              print('myProfile 이동');
            },
            child: Container(
              height: 50,
              width: 50,
              color: Colors.transparent,
              child: Icon(Icons.person),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return item();
        },
      ),
    );
  }

  Widget item() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          // TODO: chat_room 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatRoomPage();
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(color: Colors.grey[400]!),
            ),
          ),
          child: Row(
            children: [
              // TODO: 사진 뭐로?
              ClipOval(
                child: Image.network(
                  'https://picsum.photos/200/300',
                  height: 60,
                  width: 60,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '숭의동',
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          '30분 전',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      '안녕하세요. 반갑습니다.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
