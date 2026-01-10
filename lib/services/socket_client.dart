import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SocketClient {
  Future<void> createSocketConnection() async {
    final String baseUrl = dotenv.env["BASE_URL"] ?? '';
    IO.Socket socket = IO.io(
      baseUrl,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );
    socket.onConnect((_) {
      print('✅ Connected to socket: ${socket.id}');
    });
    socket.onDisconnect((_) => print('disconnect'));
  }
}
