import 'package:chat_app/db/db_provider.dart';
import 'package:chat_app/modal/message_item_modal.dart';
import 'package:sqflite/sqflite.dart';

class MessageDao {
  Future<void> insert(MessageItemModal message) async {
    final Database db = await DBProvider.db.database;
    await db.insert(
      'messages',
      message.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MessageItemModal>> getMessagesByUserId(String userId) async {
    final db = await DBProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'messages',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'messageAt ASC',
    );
    print(maps);
    return List.generate(maps.length, (i) {
      return MessageItemModal.fromJson(maps[i]);
    });
  }
}
