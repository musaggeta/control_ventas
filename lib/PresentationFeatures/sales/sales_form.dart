import 'package:control_ventas/applicationProviders/movimiento_provider.dart';
import 'package:control_ventas/applicationProviders/producto_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/producto.dart';
import '../../models/movimiento.dart';

class VentaForm extends ConsumerStatefulWidget {
  const VentaForm({super.key});

  @override
  ConsumerState<VentaForm> createState() => _VentaFormState();
}

class _VentaFormState extends ConsumerState<VentaForm> {
  Producto? _productoSeleccionado;
  final _cantidadController = TextEditingController();
  final _precioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _guardarVenta() async {
    if (!_formKey.currentState!.validate() || _productoSeleccionado == null)
      return;

    final movimiento = Movimiento(
      productoId: _productoSeleccionado!.id!,
      tipo: 'venta',
      cantidad: double.parse(_cantidadController.text),
      precioUnitario: double.parse(_precioController.text),
      fecha: DateTime.now(),
    );

    await ref.read(movimientoProvider.notifier).addMovimiento(movimiento);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Venta registrada correctamente')),
    );

    Navigator.pop(context); // Vuelve atrás
  }

  @override
  Widget build(BuildContext context) {
    final productos = ref.watch(productoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Venta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: productos.isEmpty
            ? const Center(child: Text('⚠️ No hay productos registrados'))
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<Producto>(
                      value: _productoSeleccionado,
                      hint: const Text('Selecciona un producto'),
                      items: productos.map((producto) {
                        return DropdownMenuItem(
                          value: producto,
                          child: Text(producto.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _productoSeleccionado = value);
                      },
                      validator: (value) =>
                          value == null ? '⚠️ Selecciona un producto' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _cantidadController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Cantidad'),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return '⚠️ Ingresa cantidad';
                        if (double.tryParse(value) == null)
                          return '⚠️ Ingresa un número válido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _precioController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Precio unitario',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return '⚠️ Ingresa precio';
                        if (double.tryParse(value) == null)
                          return '⚠️ Ingresa un número válido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _guardarVenta,
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
