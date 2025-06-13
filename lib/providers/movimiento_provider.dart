import 'package:finanzas/models/movimiento_model.dart';
import 'package:finanzas/providers/db_provider.dart';
import 'package:flutter/material.dart';

class MovimientoProvider extends ChangeNotifier {
  List<MovimientoModel> movimientos = [];

  nuevo(String descripcion, DateTime fecha, double importe, String tipo) async {
    final nuevoMovimiento = MovimientoModel(
      descripcion: descripcion,
      fecha: fecha,
      importe: importe,
      tipo: tipo,
    );

    final nuevoId = await DBProvider.db.nuevoMovimiento(nuevoMovimiento);
    nuevoMovimiento.id = nuevoId;
    movimientos.add(nuevoMovimiento);
    notifyListeners();
  }

  listar() async {
    final datos = await DBProvider.db.listarMovimientos();
    movimientos = [...?datos]; // Spread => Genera una colección a partir de otra coleccion
    notifyListeners();
  }
}
