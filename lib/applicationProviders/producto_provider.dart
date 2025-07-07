import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/producto_dao.dart';
import '../models/producto.dart';

final productoListProvider = FutureProvider<List<Producto>>((ref) async {
  return await ProductoDao().getAll();
});

final productoControllerProvider = Provider((ref) => ProductoDao());
