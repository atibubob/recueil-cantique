import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/cantique.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cantiques.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE cantiques (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      titre TEXT NOT NULL,
      contenu TEXT NOT NULL,
      isFavori INTEGER NOT NULL
    )
    ''');

    await db.insert('cantiques', {'titre': 'Amazing Grace', 'contenu': 'Amazing grace! How sweet the sound...', 'isFavori': 0});
    await db.insert('cantiques', {'titre': 'Gloire à Dieu', 'contenu': 'Gloire à Dieu au plus haut des cieux...', 'isFavori': 0});
  }

  Future<List<Cantique>> getAllCantiques() async {
    final db = await instance.database;
    final result = await db.query('cantiques', orderBy: 'titre');
    return result.map((json) => Cantique.fromMap(json)).toList();
  }

  Future<List<Cantique>> getFavoris() async {
    final db = await instance.database;
    final result = await db.query('cantiques', where: 'isFavori = 1');
    return result.map((json) => Cantique.fromMap(json)).toList();
  }

  Future<List<Cantique>> searchCantiques(String keyword) async {
    final db = await instance.database;
    final result = await db.query('cantiques', where: 'titre LIKE ?', whereArgs: ['%$keyword%']);
    return result.map((json) => Cantique.fromMap(json)).toList();
  }

  Future<int> updateCantique(Cantique cantique) async {
    final db = await instance.database;
    return db.update('cantiques', cantique.toMap(), where: 'id = ?', whereArgs: [cantique.id]);
  }
}
