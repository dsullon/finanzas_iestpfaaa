// ENCARGADO DE LA PERSISTENCIA DE LOS DATOS
import 'dart:io';

import 'package:finanzas/models/movimiento_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  /* 
    Patron Singleton: Creación de instancia unica.
    - Constructor privado
    - Método de accesibilidad que devuelva el objeto creado.
      Si el objeto aún no ha sido creado, el método lo tiene que crear 
  */
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  //getter para el singleton
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory directorio = await getApplicationDocumentsDirectory();
    final rutaDB = join(directorio.path, "finanzas.db");
    return await openDatabase(
      rutaDB,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE movimientos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            descripcion TEXT,
            fecha DATE,
            importe DECIMAL,
            tipo TEXT
          );
      ''');
      },
    );
  }

  nuevoMovimiento(MovimientoModel movimiento) async {
    final db = await database;
    final resultado = await db!.insert('movimientos', movimiento.toMap());
    return resultado;
  }

  Future<List<MovimientoModel>?> listarMovimientos() async {
    final db = await database;
    final resultado = await db!.query('movimientos');
    return resultado.isNotEmpty
        ? resultado.map((m) => MovimientoModel.fromMap(m)).toList()
        : null;
  }

  Future<MovimientoModel?> obtenerMovimientoPorId(int id) async {
    final db = await database;
    final resultado = await db!.query(
      'movimientos',
      where: 'id = ?',
      whereArgs: [id],
    );
    return resultado.isNotEmpty
        ? MovimientoModel.fromMap(resultado.first)
        : null;
  }
}
