class SocketInvitedToRoom {
  final String roomId;
  final String from;
  final String name;
  final String? profilePic;
  final DateTime messageSentAt;
  final String? message;

  const SocketInvitedToRoom({
    required this.roomId,
    required this.from,
    required this.name,
    this.profilePic,
    required this.messageSentAt,
    this.message,
  });

  factory SocketInvitedToRoom.fromJson(Map<String, dynamic> json) {
    return SocketInvitedToRoom(
      roomId: json["roomId"] as String,
      from: json["from"] as String,
      name: json["name"] as String,
      messageSentAt: DateTime.fromMillisecondsSinceEpoch(
        json["messageSentAt"] as int,
      ),
      message: json["message"] as String?,
      profilePic: json["profilePic"] as String?,
    );
  }
}
