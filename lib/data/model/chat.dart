class Chat {
  String chatRoomId;
  String userId;
  String userImage;
  String nickname;
  String message;
  DateTime timeStamp;

  Chat({
    required this.chatRoomId,
    required this.userId,
    required this.userImage,
    required this.nickname,
    required this.message,
    required this.timeStamp,
  });

  Chat.fromJson(Map<String, dynamic> map)
      : this(
          chatRoomId: map['chatRoomId'],
          userId: map['userId'],
          userImage: map['userImage'],
          nickname: map['nickname'],
          message: map['message'],
          timeStamp: DateTime.parse(map['timeStamp']),
        );

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      'userId': userId,
      'userImage': userImage,
      'nickname': nickname,
      'message': message,
      'timeStamp': timeStamp.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'chatRoomId: $chatRoomId, userId: $userId, userImage: $userImage, nickname: $nickname, message: $message, timeStamp: $timeStamp';
  }
}
