import 'package:chat_app/services/socket_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final socketStateProvider = Provider((ref) {
  return SocketClient();
});
