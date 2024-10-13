import 'package:flutter/material.dart';
import 'Paginas/inicio.dart';
import 'Paginas/confi.dart';
import 'Paginas/carga.dart';
import 'Paginas/perfil.dart';
import 'Paginas/prueba.dart';

void main() => runApp(MaterialApp(
  initialRoute: "inicio",
  debugShowCheckedModeBanner: false,
  routes:
  {
    Inicio.routeName: (context) => Inicio(),
    Opciones.routeName: (context) => Opciones(),
    Perfil.routeName: (context) => Perfil(),
    Carga.routeName: (context) => Carga(),
    Prueba.routeName: (context) => Prueba(),
  },
));