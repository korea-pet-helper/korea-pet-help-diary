import 'package:flutter/material.dart';
import 'package:korea_pet_help_diary/ui/widgets/user_profile_image.dart';

class ChatRoomReceive extends StatelessWidget {
  // true: 프로필 보이기 false: 프로필 안보이기
  bool showProfile;
  ChatRoomReceive({required this.showProfile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Column(
        children: [
          // showProfile 가 true 면 프로필 보이기 false 면 빈 박스
          showProfile == true ? reciverProfile() : const SizedBox(),
          // 메시지 내용
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 50, height: 50),
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
                  '안녕하세요 처음 뵙겠습니다!안녕하세요 처음 뵙겠습니다!',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              // 시간
              Text(
                '10분전',
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

  Row reciverProfile() {
    return Row(
      children: [
        // 프로필 사진
        UserProfileImage(
          size: 50,
          imageUrl: 'https://picsum.photos/200/300',
        ),
        const SizedBox(width: 10),
        // 닉네임
        Text('닉네임', style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
