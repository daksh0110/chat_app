import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<List<Map<String, dynamic>>> getMessages(String userId) async {
    final db = await database;
    var res = await db.query("messages", where: "userId = ?", whereArgs: [userId]);
    return res.isNotEmpty ? res.toList() : [];
  }
}

initDB() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, "chat_app.db");
  return await openDatabase(
    path,
    version: 4, // Incremented version
    onOpen: (db) {},
    onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE chat_list (
          id TEXT PRIMARY KEY,
          name TEXT,
          profilePic TEXT,
          newMessageCount INTEGER,
          lastMessageAt INTEGER,
          roomId TEXT,
          message TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE messages (
          id TEXT PRIMARY KEY,
          userId TEXT,
          message TEXT,
          messageBy INTEGER,
          messageAt INTEGER,
          status INTEGER
        )
      ''');
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (oldVersion < 2) {
        await db.execute("ALTER TABLE messages ADD COLUMN messageBy INTEGER");
      }
      if (oldVersion < 3) {
        await db.execute("ALTER TABLE messages ADD COLUMN messageAt INTEGER");
      }
      if (oldVersion < 4) {
        // This is a destructive migration.
        // I'm dropping the old table and creating a new one because you wanted to replace roomId with userId.
        // In a production app, you would want a non-destructive migration.
        await db.execute("DROP TABLE IF EXISTS messages");
        await db.execute('''
          CREATE TABLE messages (
            id TEXT PRIMARY KEY,
            userId TEXT,
            message TEXT,
            messageBy INTEGER,
            messageAt INTEGER,
            status INTEGER
          )
        ''');
      }
    },
  );
}
