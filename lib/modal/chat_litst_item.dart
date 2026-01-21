import 'package:chat_app/modal/backend/socket_invited_to_room.dart';
import 'package:chat_app/modal/message_item_modal.dart';
import 'package:flutter/material.dart';

class ChatListItem {
  final String name;
  final String message;
  final ImageProvider profilePic;
  final int newMessageCount;
  final DateTime? lastMessageAt;
  final String roomId;
  final String id;

  ChatListItem({
    required this.name,
    this.message = "",
    this.profilePic = const AssetImage("assets/images/1.png"),
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

  ChatListItem updateInfo(ChatListItem? data) {
    return ChatListItem(
      name: data?.name ?? name,
      id: data?.id ?? id,
      lastMessageAt: data?.lastMessageAt ?? lastMessageAt,
      message: data?.message ?? message,
      newMessageCount: newMessageCount + 1,
      profilePic: data?.profilePic ?? profilePic,
      roomId: data?.roomId ?? roomId,
    );
  }
}
