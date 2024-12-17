import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/data/model/chat_preview.dart';
import 'package:korea_pet_help_diary/data/model/user.dart';
import 'package:korea_pet_help_diary/ui/pages/chat_room/chat_room_page.dart';
import 'package:korea_pet_help_diary/ui/pages/home/home_view_model.dart';
import 'package:korea_pet_help_diary/ui/pages/profile_fix/profile_fix_page.dart';
import 'package:korea_pet_help_diary/ui/user_global_view_model.dart';
import 'package:korea_pet_help_diary/ui/widgets/user_profile_image.dart';
import 'package:korea_pet_help_diary/util/date_time_format.dart';

class HomePage extends StatelessWidget {
  User user;
  HomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final userState = ref.watch(userGlobalViewModelProvider(user.userId));
      final userVm =
          ref.watch(userGlobalViewModelProvider(user.userId).notifier);

      user = userState ?? user;
      final state = ref.watch(homeViewModelProvider(user));
      final vm = ref.watch(homeViewModelProvider(user).notifier);

      return Scaffold(
        appBar: AppBar(
          title: Text(user.local),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfileFixPage(user);
                    },
                  ),
                ).then((value) {
                  vm.fetchChatPreivew();
                  userVm.fetchUserInfo();
                });
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
        body: state.chatPreviewList?.isEmpty ?? true
            ? const Center(
                child: Text(
                  '참여했던 채팅방이 없습니다.\n지금 바로 지역 채팅방으로 이동하세요!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: state.chatPreviewList!.length,
                itemBuilder: (context, index) {
                  return item(state.chatPreviewList![index]);
                },
              ),
        floatingActionButton: SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () async {
              final chatPreview = await vm.getMyChatPreview(userState!);
              // 채팅방으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatRoomPage(
                      preview: chatPreview!,
                      user: user,
                    );
                  },
                ),
              ).then((value) {
                vm.fetchChatPreivew();
                userVm.fetchUserInfo();
              }); // 뒤로갈 때 새로고침
            },
            child: const Text(
              '지역 채팅방으로 이동',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }

  /// 채팅방 박스
  Widget item(ChatPreview preview) {
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: () {
            // 채팅방으로 이동
            final vm = ref.watch(homeViewModelProvider(user).notifier);
            final userVm =
                ref.watch(userGlobalViewModelProvider(user.userId).notifier);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatRoomPage(
                    preview: preview,
                    user: user,
                  );
                },
              ),
            ).then((value) {
              vm.fetchChatPreivew();
              userVm.fetchUserInfo();
            }); // 뒤로갈 때 새로고침
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
      },
    );
  }
}
