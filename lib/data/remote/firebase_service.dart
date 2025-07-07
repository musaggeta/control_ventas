import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_ventas/data/local/movimiento_dao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/movimiento.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get uid => _auth.currentUser?.uid ?? 'anon';

  // Guardar fecha de última sincronización
  Future<void> saveLastSync(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSync_$uid', date.toIso8601String());
  }

  Future<DateTime?> getLastSync() async {
    final prefs = await SharedPreferences.getInstance();
    final dateStr = prefs.getString('lastSync_$uid');
    return dateStr != null ? DateTime.parse(dateStr) : null;
  }

  Future<void> subirMovimiento(Movimiento mov) async {
    await _firestore.collection('movimientos').add({
      'producto_id': mov.productoId,
      'tipo': mov.tipo,
      'cantidad': mov.cantidad,
      'precio_unitario': mov.precioUnitario,
      'fecha': mov.fecha.toIso8601String(),
      'usuario_id': uid,
    });
  }

  Future<List<Movimiento>> obtenerMovimientosCompartidos() async {
    final snapshot = await _firestore
        .collection('movimientos')
        .where('usuario_id', isEqualTo: uid)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Movimiento(
        id: 0,
        productoId: data['producto_id'],
        tipo: data['tipo'],
        cantidad: (data['cantidad'] as num).toDouble(),
        precioUnitario: (data['precio_unitario'] as num).toDouble(),
        fecha: DateTime.parse(data['fecha']),
      );
    }).toList();
  }

  final _movimientoDao = MovimientoDao();

  Future<void> syncDesdeFirestore() async {
    final lastSync = await getLastSync();
    final query = _firestore
        .collection('movimientos')
        .where('usuario_id', isEqualTo: uid);

    final snapshot = await (lastSync != null
        ? query.where('fecha', isGreaterThan: lastSync.toIso8601String()).get()
        : query.get());

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final mov = Movimiento(
        id: 0,
        productoId: data['producto_id'],
        tipo: data['tipo'],
        cantidad: (data['cantidad'] as num).toDouble(),
        precioUnitario: (data['precio_unitario'] as num).toDouble(),
        fecha: DateTime.parse(data['fecha']),
      );

      // Insertar si no existe (por ahora, sin duplicados sofisticados)
      await _movimientoDao.insert(mov);
    }

    // Actualizar fecha de sincronización
    await saveLastSync(DateTime.now());
  }
}
