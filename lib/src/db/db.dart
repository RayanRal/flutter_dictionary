import 'package:dict_proj/src/db/dict_word.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbManager {
  static const String TABLE_NAME = "words";

  static Future<Database> initDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'dict_data.db'),
      onCreate: (db, version) async {
        var b = db.batch();
        b.execute("DROP TABLE IF EXISTS $TABLE_NAME");
        b.execute(
          'CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY AUTOINCREMENT, original TEXT, translation TEXT)',
        );
        await b.commit();
      },
      version: 1,
    );
  }

  static Future<void> insertDictWord(DictWord word) async {
    final db = await initDb();

    await db.insert(
      TABLE_NAME,
      word.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertWord(String original, String translation) async {
    final db = await initDb();

    await db.insert(
      TABLE_NAME,
      {
        'original': original,
        'translation': translation,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<DictWord>> getWords() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

    return List.generate(maps.length, (i) {
      return DictWord(
        id: maps[i]['id'] as int,
        original: maps[i]['original'] as String,
        translation: maps[i]['translation'] as String,
      );
    });
  }

  static Future<void> updateWord(DictWord word) async {
    final db = await initDb();

    await db.update(
      TABLE_NAME,
      word.toMap(),
      where: 'id = ?',
      whereArgs: [word.id],
    );
  }

  static Future<void> deleteWord(int id) async {
    final db = await initDb();

    await db.delete(
      TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
