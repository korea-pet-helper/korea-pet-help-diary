class ChatPreview {
  String chatRoomId;
  String local;
  String message;
  DateTime timeStamp;
  String thumbnail;

  ChatPreview({
    required this.chatRoomId,
    required this.local,
    required this.message,
    required this.timeStamp,
    required this.thumbnail,
  });

  ChatPreview.fronJson(Map<String, dynamic> map)
      : this(
          chatRoomId: map['chatRoomId'],
          local: map['local'],
          message: map['message'],
          timeStamp: DateTime.parse(map['timeStamp']),
          thumbnail: map['thumbnail'],
        );

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      'local': local,
      'message': message,
      'timeStamp': timeStamp,
      'thumbnail': thumbnail,
    };
  }

  @override
  String toString() {
    return 'chatRoomId: $chatRoomId, local: $local, message: $message, timeStamp: $timeStamp, thumbnail: $thumbnail';
  }
}
