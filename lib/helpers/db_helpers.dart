import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBhelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBhelper.database();
    db.insert('user_places', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBhelper.database();
    return db.query(table);
  }

  static Future<void> delDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    String dbpath = path.join(dbPath, 'places.db');
    await sql.deleteDatabase(dbpath);
  }
}
