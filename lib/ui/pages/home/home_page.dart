import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/data/model/chat_preview.dart';
import 'package:korea_pet_help_diary/ui/pages/chat_room/chat_room_page.dart';
import 'package:korea_pet_help_diary/ui/pages/home/home_view_model.dart';
import 'package:korea_pet_help_diary/ui/widgets/user_profile_image.dart';
import 'package:korea_pet_help_diary/util/date_time_format.dart';

class HomePage extends StatelessWidget {
  String localCode;
  HomePage({required this.localCode});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(homeViewModelProvider(localCode));
      return Scaffold(
        appBar: AppBar(
          // TODO: 유저의 동네 가져오기
          title: Text('삼성동'),
          actions: [
            GestureDetector(
              onTap: () {
                // TODO: myProfile 페이지로 이동
                print('myProfile 이동');
              },
              // 내 프로필 페이지로 이동할 아이콘
              child: Container(
                height: 50,
                width: 50,
                color: Colors.transparent,
                child: Icon(Icons.person),
              ),
            )
          ],
        ),
        // 채팅방 리스트
        body: ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            return item(state[index]!);
          },
        ),
      );
    });
  }

  /// 채팅방 박스
  Widget item(ChatPreview preview) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          // 채팅방으로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatRoomPage(chatRoomId: preview.chatRoomId);
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
              UserProfileImage(
                size: 60,
                imageUrl: preview.thumbnail,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          preview.local,
                          style: TextStyle(fontSize: 20),
                        ),
                        const Spacer(),
                        Text(
                          DateTimeFormat.formatString(preview.timeStamp),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      preview.message,
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
