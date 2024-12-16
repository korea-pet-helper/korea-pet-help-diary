import 'package:flutter/material.dart';
import 'package:korea_pet_help_diary/data/model/chat.dart';
import 'package:korea_pet_help_diary/ui/widgets/user_profile_image.dart';
import 'package:korea_pet_help_diary/util/date_time_format.dart';

class ChatRoomReceive extends StatelessWidget {
  // true: 프로필 보이기 false: 프로필 안보이기
  bool showProfile;
  Chat chat;
  ChatRoomReceive({required this.showProfile, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Column(
        children: [
          // showProfile 가 true 면 프로필 보이기 false 면 빈 박스
          showProfile == true ? reciverProfile() : const SizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 프로필 사진만큼 앞 부분 띄기
              const SizedBox(width: 50, height: 50),
              // 메시지 내용
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
                  chat.message,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              // 시간
              Text(
                DateTimeFormat.formatChatTime(chat.timeStamp),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget reciverProfile() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          // 프로필 사진
          UserProfileImage(
            size: 50,
            imageUrl: chat.userImage,
          ),
          const SizedBox(width: 10),
          // 닉네임
          Text(chat.nickname, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
