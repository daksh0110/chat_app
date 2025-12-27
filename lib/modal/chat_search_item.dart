import 'package:flutter/material.dart';

class ChatSearchItem {
  final String id;
  final String name;
  final ImageProvider userMainImageUrl;
  final String email;

  ChatSearchItem({
    required this.id,
    required this.name,
    this.userMainImageUrl = const AssetImage("assets/images/1.png"),
    required this.email,
  });
  factory ChatSearchItem.fromJson(Map<String, dynamic> json) {
    final String? imageUrl = json['userMainImageUrl'];
    return ChatSearchItem(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userMainImageUrl: (imageUrl != null && imageUrl.isNotEmpty)
          ? NetworkImage(imageUrl)
          : const AssetImage("assets/images/1.png"),
    );
  }
}
