import 'package:control_ventas/core/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/movimiento_dao.dart';
import '../models/movimiento.dart';
import '../core/extensions.dart';

final reporteMensualProvider =
    FutureProvider.family<Map<String, dynamic>, DateTime>((ref, fecha) async {
      final movimientos = await MovimientoDao().getByMes(fecha);
      return calcularReporte(movimientos); // función en helpers.dart
    });
