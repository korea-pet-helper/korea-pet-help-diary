class Chat {
  String userId;
  String userImage;
  String nickname;
  String message;
  DateTime timeStamp;

  Chat({
    required this.userId,
    required this.userImage,
    required this.nickname,
    required this.message,
    required this.timeStamp,
  });

  Chat.fromJson(Map<String, dynamic> map)
      : this(
          userId: map['userId'],
          userImage: map['userImage'],
          nickname: map['nickname'],
          message: map['message'],
          timeStamp: DateTime.parse(map['timeStamp']),
        );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userImage': userImage,
      'nickname': nickname,
      'message': message,
      'timeStamp': timeStamp.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'userId: $userId, userImage: $userImage, nickname: $nickname, message: $message, timeStamp: $timeStamp';
  }
}
