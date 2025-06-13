import 'package:finanzas/providers/db_provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DBProvider.db.database;
    return Scaffold(appBar: AppBar(title: Text("Finanza personal")));
  }
}
