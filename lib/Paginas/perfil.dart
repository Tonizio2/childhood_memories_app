import 'package:flutter/material.dart';
import 'inicio.dart';

class Perfil extends StatefulWidget {
  static const routeName = 'perfil';
  @override
  State<Perfil> createState() => PerfilEstado();
}

class PerfilEstado extends State<Perfil> {
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Container
      (
        decoration: BoxDecoration
        (
          image: DecorationImage
          (
            image: AssetImage("imagenes/fondo.png"),
            fit: BoxFit.cover
          )
        ),
            
        child: Container
        (child: SafeArea(
          child: Column
          (children:
              [Navegacion(),Spacer(),Tarjeta(),Spacer(),]
            ),
        ),
        ),
      ),
    );
  }
}

class Tarjeta extends StatefulWidget {
  @override
  State<Tarjeta> createState() => TarjetaState();
}

class TarjetaState extends State<Tarjeta> {
  var usuario = "Toni";
  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      decoration: BoxDecoration
      (
        color: Color.fromRGBO(73, 87, 212, 1),
        borderRadius: BorderRadius.only
        (
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )
      ),
      width: 300,
      child: Center
      (
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>
          [
            Padding(padding: EdgeInsets.fromLTRB(30, 20, 30, 0)),
            CircleAvatar(backgroundImage: AssetImage("imagenes/icono.png"),radius: 80,),
            SizedBox(height: 10),
            Text("NOMBRE", style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), letterSpacing: 2,),),
            SizedBox(height: 10),
            Text("TONI", style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), letterSpacing: 2, fontSize: 28, fontWeight: FontWeight.bold),),
            SizedBox(height: 10),

            Row
            (
              children: 
              [
                Spacer(),
                Column
                (children: 
                  [
                    Padding(padding: EdgeInsets.fromLTRB(0, 20, 30, 0)),
                    Text("Max Score", style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), letterSpacing: 2,),),
                    SizedBox(height: 10),
                    Text("0", style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), letterSpacing: 2, fontSize: 28, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10),
                  ],
                ),
                Spacer(),
                Column
                (children: 
                  [
                    Padding(padding: EdgeInsets.fromLTRB(0, 20, 30, 0)),
                    Text("Score Total", style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), letterSpacing: 2,),),
                    SizedBox(height: 10),
                    Text("0", style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), letterSpacing: 2, fontSize: 28, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10),
                  ],
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}