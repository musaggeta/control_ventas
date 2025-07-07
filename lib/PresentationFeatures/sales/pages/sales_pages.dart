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
    final ventasAsync = ref.watch(movimientoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Agregar filtros
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: ventasAsync.when(
        data: (movimientos) {
          final ventas = movimientos.where((m) => m.tipo == 'venta').toList()
            ..sort((a, b) => b.fecha.compareTo(a.fecha));

          if (ventas.isEmpty) {
            return const Center(child: Text('No hay ventas registradas.'));
          }

          return ListView.builder(
            itemCount: ventas.length,
            itemBuilder: (context, index) {
              final venta = ventas[index];
              return SaleItem(venta);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
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
      builder: (context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('TODO: Formulario de nueva venta'),
          ),
        );
      },
    );
  }
}
