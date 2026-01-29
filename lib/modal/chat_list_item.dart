import 'package:chat_app/modal/backend/socket_invited_to_room.dart';
import 'package:chat_app/modal/message_item_modal.dart';
import 'package:flutter/material.dart';

class ChatListItem {
  final String name;
  final String message;
  final String profilePic;
  final int newMessageCount;
  final DateTime? lastMessageAt;
  final String roomId;
  final String id;

  ChatListItem({
    required this.name,
    this.message = "",
    this.profilePic = "",
    this.newMessageCount = 0,
    this.lastMessageAt,
    this.roomId = "",
    required this.id,
  });

  factory ChatListItem.fromSocket(SocketInvitedToRoom data) {
    return ChatListItem(
      id: data.from,
      roomId: data.roomId,
      name: data.name,
      lastMessageAt: data.messageSentAt,
      newMessageCount: 1,
      message: data.message ?? "",

      // profilePic stays default for now
    );
  }

  ChatListItem resetCount() {
    return ChatListItem(
      name: name,
      id: id,
      lastMessageAt: lastMessageAt,
      message: message,
      newMessageCount: 0,
      profilePic: profilePic,
      roomId: roomId,
    );
  }

  ChatListItem assignRoomId(String RoomId) {
    return ChatListItem(
      name: name,
      id: id,
      lastMessageAt: lastMessageAt,
      message: message,
      newMessageCount: 0,
      profilePic: profilePic,
      roomId: RoomId,
    );
  }

  ChatListItem copyWith({
    String? name,
    String? message,
    DateTime? lastMessageAt,
    int? newMessageCount,
    String? profilePic,
    String? roomId,
  }) {
    return ChatListItem(
      name: name ?? this.name,
      id: id,
      message: message ?? this.message,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      newMessageCount: newMessageCount ?? this.newMessageCount,
      profilePic: profilePic ?? this.profilePic,
      roomId: roomId ?? this.roomId,
    );
  }
}
