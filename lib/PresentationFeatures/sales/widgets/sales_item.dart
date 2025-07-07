import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/movimiento.dart';

class SaleItem extends StatelessWidget {
  final Movimiento venta;
  const SaleItem(this.venta, {super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMMMd('es_ES');

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        title: Text('Producto ID: ${venta.productoId}'),
        subtitle: Text(
          'Cantidad: ${venta.cantidad} ${venta.precioUnitario.toStringAsFixed(2)} Bs/u',
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${venta.total.toStringAsFixed(2)} Bs.',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              formatter.format(venta.fecha),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
