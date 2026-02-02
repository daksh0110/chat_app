import 'package:chat_app/modal/backend/socket_invited_to_room.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SocketClient {
  IO.Socket? socket;

  Future<void> createSocketConnection(String token) async {
    if (socket?.connected == true) return;

    final String baseUrl = dotenv.env["BASE_URL"] ?? '';

    socket = IO.io(
      baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .disableAutoConnect()
          .build(),
    );

    socket!.connect();

    socket!.onConnect((_) {
      print('✅ Connected to socket: ${socket!.id}');
    });

    socket!.onDisconnect((_) {
      print('❌ Disconnected from socket');
    });

    socket!.onConnectError((err) {
      print('❌ Connection error: $err');
    });
  }

  void sendMessage({
    required String receiver,
    required String message,
    String? roomId,
  }) {
    if (socket == null || socket!.connected != true) {
      return;
    }

    socket!.emit('send_private_message', {
      'receiver': receiver,
      'message': message,
      'roomId': roomId,
    });
  }

  void recieveMessage({
    required void Function(String from, String message, DateTime messageSentAt)
    onMessage,
  }) {
    socket?.on("receive_private_message", (data) {
      print(data);
      final String from = data["sender"];
      final String message = data["message"];
      final DateTime messageSentAt = DateTime.fromMillisecondsSinceEpoch(
        data["messageSentAt"] as int,
      );
      onMessage(from, message, messageSentAt);
    });
  }

  void removeMessageListener() {
    socket?.off("receive_private_message");
  }

  void removeJoinedRoomListener() {
    socket?.off('joined_room');
  }

  void disconnect() {
    socket?.disconnect();
    socket?.dispose();
    socket = null;
  }

  void invitedToRoom({
    required Function(SocketInvitedToRoom data) onInvitation,
  }) {
    socket?.on("invited_to_room", (data) {
      final invitation = SocketInvitedToRoom.fromJson(
        Map<String, dynamic>.from(data),
      );
      onInvitation(invitation);
    });
  }

  void roomCreated({
    required Function(String roomId, String userId) onRoomCreated,
  }) {
    socket?.on("room-created", (data) {
      final roomId = data["roomId"] as String;
      final userId = data["userId"] as String;
      onRoomCreated(roomId, userId);
    });
  }
}
