class Movimiento {
  double get total => cantidad * precioUnitario;

  final int? id;
  final int productoId;
  final String tipo; // "compra" o "venta"
  final double cantidad;
  final double precioUnitario;
  final DateTime fecha;

  Movimiento({
    this.id,
    required this.productoId,
    required this.tipo,
    required this.cantidad,
    required this.precioUnitario,
    required this.fecha,
  });

  factory Movimiento.fromMap(Map<String, dynamic> map) => Movimiento(
    id: map['id'],
    productoId: map['producto_id'],
    tipo: map['tipo'],
    cantidad: map['cantidad'],
    precioUnitario: map['precio_unitario'],
    fecha: DateTime.parse(map['fecha']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'producto_id': productoId,
    'tipo': tipo,
    'cantidad': cantidad,
    'precio_unitario': precioUnitario,
    'fecha': fecha.toIso8601String(),
  };
}
