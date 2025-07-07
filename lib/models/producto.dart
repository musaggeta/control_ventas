class Producto {
  final int? id;
  final String nombre;
  final String unidadMedida;

  Producto({this.id, required this.nombre, required this.unidadMedida});

  factory Producto.fromMap(Map<String, dynamic> map) => Producto(
    id: map['id'],
    nombre: map['nombre'],
    unidadMedida: map['unidad_medida'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'nombre': nombre,
    'unidad_medida': unidadMedida,
  };
}
