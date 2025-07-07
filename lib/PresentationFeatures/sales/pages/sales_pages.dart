import 'package:control_ventas/PresentationFeatures/sales/widgets/sales_item.dart';
import 'package:control_ventas/applicationProviders/movimiento_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../models/movimiento.dart';

class SalesPage extends ConsumerWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movimientos = ref.watch(movimientoProvider);
    final notifier = ref.read(movimientoProvider.notifier);

    final ventas = movimientos.where((m) => m.tipo == 'venta').toList()
      ..sort((a, b) => b.fecha.compareTo(a.fecha));

    return Scaffold(
      appBar: AppBar(title: const Text('Ventas')),
      body: ventas.isEmpty
          ? const Center(child: Text('No hay ventas registradas'))
          : ListView.builder(
              itemCount: ventas.length,
              itemBuilder: (context, index) {
                final venta = ventas[index];
                return Dismissible(
                  key: ValueKey(venta.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    if (venta.id != null) {
                      notifier.deleteMovimiento(venta.id!);
                    }
                  },
                  child: SaleItem(venta),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _mostrarFormularioVenta(context, ref);
        },
        icon: const Icon(Icons.add),
        label: const Text('Registrar venta'),
      ),
    );
  }

  void _mostrarFormularioVenta(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => const Dialog(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('TODO: Aquí va el formulario de nueva venta'),
        ),
      ),
    );
  }
}
