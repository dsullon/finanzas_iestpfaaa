import 'package:finanzas/providers/db_provider.dart';
import 'package:finanzas/providers/movimiento_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movimientoProvider = Provider.of<MovimientoProvider>(context);
    movimientoProvider.listar();
    final movimientos = movimientoProvider.movimientos;
    return Scaffold(
      appBar: AppBar(title: Text("Finanza personal")),
      body: Column(
        children: [
          Text(
            "Aquí colocar datos del usuario y el saldo según sus movimientos",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: movimientos.length,
              itemBuilder: (_, index) {
                final movimiento = movimientos[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(movimiento.fecha.toString()),
                      Text(
                        movimiento.importe.toString(),
                        style: TextStyle(
                          color: movimiento.tipo == "A"
                              ? Colors.blue
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(movimiento.descripcion),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
