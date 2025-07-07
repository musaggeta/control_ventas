import '../../models/producto.dart';
import 'db_helper.dart';

class ProductoDao {
  final dbHelper = DBHelper();

  Future<int> insert(Producto producto) async {
    final db = await dbHelper.db;
    return await db.insert('productos', producto.toMap());
  }

  Future<List<Producto>> getAll() async {
    final db = await dbHelper.db;
    final List<Map<String, dynamic>> maps = await db.query('productos');
    return maps.map((map) => Producto.fromMap(map)).toList();
  }

  Future<int> update(Producto producto) async {
    final db = await dbHelper.db;
    return await db.update(
      'productos',
      producto.toMap(),
      where: 'id = ?',
      whereArgs: [producto.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await dbHelper.db;
    return await db.delete('productos', where: 'id = ?', whereArgs: [id]);
  }
}
