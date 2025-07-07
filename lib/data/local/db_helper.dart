import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _db;

  DBHelper._internal();

  factory DBHelper() => _instance;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'registro_app.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE productos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        unidad_medida TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE movimientos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        producto_id INTEGER NOT NULL,
        tipo TEXT NOT NULL,
        cantidad REAL NOT NULL,
        precio_unitario REAL NOT NULL,
        fecha TEXT NOT NULL,
        FOREIGN KEY (producto_id) REFERENCES productos(id)
      )
    ''');
  }
}
