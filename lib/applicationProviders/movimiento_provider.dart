import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/movimiento_dao.dart';
import '../models/movimiento.dart';

final movimientoListProvider = FutureProvider<List<Movimiento>>((ref) async {
  return await MovimientoDao().getAll();
});

final movimientoControllerProvider = Provider((ref) => MovimientoDao());
