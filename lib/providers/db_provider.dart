// ENCARGADO DE LA PERSISTENCIA DE LOS DATOS
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  // Patron Singleton
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  //getter para el singleton
  get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory directorio = await getApplicationDocumentsDirectory();
    final rutaDB = join(directorio.path, "finanzas.db");
    print("Ruta de Base de datos");
    print(rutaDB);
    return await openDatabase(
      rutaDB,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE movimientos(
            id INTEGER PRIMARY KEY,
            descripcion TEXT,
            fecha DATE,
            importe DECIMAL
          );
      ''');
      },
    );
  }
}
