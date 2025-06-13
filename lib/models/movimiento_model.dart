class MovimientoModel {
  int id;
  String descripcion;
  DateTime fecha;
  double importe;
  String tipo;

  MovimientoModel({
    this.id = 0,
    required this.descripcion,
    required this.fecha,
    required this.importe,
    required this.tipo,
  });

  factory MovimientoModel.fromMap(Map<String, dynamic> map) => MovimientoModel(
    id: map["id"],
    descripcion: map["descripcion"],
    fecha: DateTime.parse(map["fecha"]),
    importe: map["importe"]?.toDouble(),
    tipo: map["tipo"],
  );

  Map<String, dynamic> toMap() => {
    "descripcion": descripcion,
    "fecha":
        "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
    "importe": importe,
    "tipo": tipo,
  };
}
