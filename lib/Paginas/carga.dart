import 'package:flutter/material.dart';

class Carga extends StatefulWidget {
  static const routeName = 'carga';
  @override
  CargaEstado createState() => CargaEstado();
}

class CargaEstado extends State<Carga> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>
        [
          Text("Cargando"),
        ],
      )
    );
  }
}  