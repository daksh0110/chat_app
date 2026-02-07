import 'package:chat_app/db/db_provider.dart';
import 'package:chat_app/modal/chat_list_item.dart';
import 'package:sqflite/sqflite.dart';

class ChatListItemDao {
  Future<void> insert(ChatListItem chatListItem) async {
    final Database db = await DBProvider.db.database;
    await db.insert(
      'chat_list',
      chatListItem.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> setRoomId(String roomId, String userId) async {
    final Database db = await DBProvider.db.database;
    await db.update(
      "chat_list",
      {"roomId": roomId},
      where: "id = ?",
      whereArgs: [userId],
    );
  }

  Future<List<ChatListItem>> getAll() async {
    final db = await DBProvider.db.database;
    final result = await db.query('chat_list', orderBy: 'lastMessageAt DESC');

    return result.map(ChatListItem.fromJson).toList();
  }
}
