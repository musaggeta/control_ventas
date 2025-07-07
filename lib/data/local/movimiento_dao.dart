import '../../models/movimiento.dart';
import 'db_helper.dart';

class MovimientoDao {
  final dbHelper = DBHelper();

  Future<int> insert(Movimiento m) async {
    final db = await dbHelper.db;
    return await db.insert('movimientos', m.toMap());
  }

  Future<List<Movimiento>> getAll() async {
    final db = await dbHelper.db;
    final List<Map<String, dynamic>> maps = await db.query('movimientos');
    return maps.map((map) => Movimiento.fromMap(map)).toList();
  }

  Future<List<Movimiento>> getByMes(DateTime fecha) async {
    final db = await dbHelper.db;
    final primerDia = DateTime(fecha.year, fecha.month, 1);
    final ultimoDia = DateTime(fecha.year, fecha.month + 1, 0);

    final List<Map<String, dynamic>> maps = await db.query(
      'movimientos',
      where: 'fecha >= ? AND fecha <= ?',
      whereArgs: [primerDia.toIso8601String(), ultimoDia.toIso8601String()],
    );

    return maps.map((map) => Movimiento.fromMap(map)).toList();
  }

  Future<int> deleteAll() async {
    final db = await dbHelper.db;
    return await db.delete('movimientos');
  }
}
