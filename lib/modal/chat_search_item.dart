import 'package:flutter/material.dart';

class ChatSearchItem {
  final String id;
  final String name;
  final ImageProvider userMainImageUri;
  final String email;

  ChatSearchItem({
    required this.id,
    required this.name,
    this.userMainImageUri = const AssetImage("assets/images/1.png"),
    required this.email,
  });
  factory ChatSearchItem.fromJson(Map<String, dynamic> json) {
    return ChatSearchItem(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
