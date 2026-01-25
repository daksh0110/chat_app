class ChatSearchItem {
  final String id;
  final String name;
  final String userMainImageUrl;
  final String email;

  ChatSearchItem({
    required this.id,
    required this.name,
    this.userMainImageUrl = "",
    required this.email,
  });

  factory ChatSearchItem.fromJson(Map<String, dynamic> json) {
    final String? imageUrl = json['userMainImageUrl'];
    return ChatSearchItem(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userMainImageUrl: imageUrl ?? "",
    );
  }
}
