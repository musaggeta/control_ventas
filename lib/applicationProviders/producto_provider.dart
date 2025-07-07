import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/producto_dao.dart';
import '../models/producto.dart';

class ProductoNotifier extends StateNotifier<List<Producto>> {
  final ProductoDao _dao = ProductoDao();

  ProductoNotifier() : super([]) {
    loadProductos();
  }

  Future<void> loadProductos() async {
    final productos = await _dao.getAll();
    state = productos;
  }

  Future<void> addProducto(Producto producto) async {
    await _dao.insert(producto);
    await loadProductos();
  }

  Future<void> updateProducto(Producto producto) async {
    await _dao.update(producto);
    await loadProductos();
  }

  Future<void> deleteProducto(int id) async {
    await _dao.delete(id);
    await loadProductos();
  }
}

final productoProvider =
    StateNotifierProvider<ProductoNotifier, List<Producto>>((ref) {
      return ProductoNotifier();
    });
