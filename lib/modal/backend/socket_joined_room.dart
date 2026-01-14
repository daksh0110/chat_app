class SocketJoinedRoom {
  final String roomId;
  final String id;
  final String email;
  final String name;
  final String userMainImageUrl;

  const SocketJoinedRoom({
    required this.roomId,
    required this.id,
    required this.email,
    required this.name,
    required this.userMainImageUrl,
  });

  SocketJoinedRoom.fromJson(Map<String, dynamic> json)
    : roomId = json["roomId"],
      id = json["id"],
      email = json["email"],
      name = json["name"],
      userMainImageUrl = json["userMainImageUrl"];
}
