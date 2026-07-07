import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ChatMessage {
  final int? id;
  final String text;
  final bool fromUser;

  ChatMessage({this.id, required this.text, required this.fromUser});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'fromUser': fromUser ? 1 : 0,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as int?,
      text: map['text'] as String,
      fromUser: (map['fromUser'] as int) == 1,
    );
  }
}

class ChatDatabase {
  ChatDatabase._internal();
  static final ChatDatabase instance = ChatDatabase._internal();

  Database? _db;

  Future<Database> get _database async {
    _db ??= await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), 'tp5_chat.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            text TEXT NOT NULL,
            fromUser INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<ChatMessage> addMessage(ChatMessage message) async {
    final db = await _database;
    final id = await db.insert('messages', message.toMap());
    return ChatMessage(id: id, text: message.text, fromUser: message.fromUser);
  }

  Future<List<ChatMessage>> loadHistory() async {
    final db = await _database;
    final rows = await db.query('messages', orderBy: 'id ASC');
    return rows.map(ChatMessage.fromMap).toList();
  }

  Future<void> clearHistory() async {
    final db = await _database;
    await db.delete('messages');
  }
}
