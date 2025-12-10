import 'package:flutter/material.dart';

class ChatListItem {
  final String name;
  final String message;
  final ImageProvider profilePic;
  final int newMessageCount;
  final DateTime? lastMessageAt;

  ChatListItem({
    required this.name,
    this.message = "",
    this.profilePic = const AssetImage("assets/images/1.png"),
    this.newMessageCount = 0,
    this.lastMessageAt,
  });
}
