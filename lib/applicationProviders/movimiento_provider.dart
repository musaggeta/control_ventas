import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/movimiento_dao.dart';
import '../models/movimiento.dart';

class MovimientoNotifier extends StateNotifier<List<Movimiento>> {
  final MovimientoDao _dao = MovimientoDao();

  MovimientoNotifier() : super([]) {
    loadMovimientos();
  }

  Future<void> loadMovimientos() async {
    final movimientos = await _dao.getAll();
    state = movimientos;
  }

  Future<void> addMovimiento(Movimiento movimiento) async {
    await _dao.insert(movimiento);
    await loadMovimientos();
  }

  Future<void> updateMovimiento(Movimiento movimiento) async {
    await _dao.update(movimiento);
    await loadMovimientos();
  }

  Future<void> deleteMovimiento(int id) async {
    await _dao.delete(id);
    await loadMovimientos();
  }
}

final movimientoProvider =
    StateNotifierProvider<MovimientoNotifier, List<Movimiento>>((ref) {
      return MovimientoNotifier();
    });
