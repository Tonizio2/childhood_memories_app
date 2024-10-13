import 'package:flutter/material.dart';
import 'inicio.dart';


String seleccionTemporizador = "25";
String seleccionCategoria = "Dibus";

class Opciones extends StatefulWidget {
  static const routeName = 'opciones';
  @override
  OpcionesEstado createState() => OpcionesEstado();
}

class OpcionesEstado extends State<Opciones> 
{
  @override
  Widget build(BuildContext context) {
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
        child: Container(child: SafeArea(child: Column(children: [Navegacion(),Spacer(),ListaOpciones(),Spacer(),])),),
      ),
    );
  }
}

class ListaOpciones extends StatefulWidget {
  @override
  State<ListaOpciones> createState() => ListaOpcionesState();
}

class ListaOpcionesState extends State<ListaOpciones> {

  void actualizaSeleccionTemporizador(String nuevoValor)
  {
  setState(() 
  {
    seleccionTemporizador = nuevoValor;
  });
  }

  void actualizaSeleccionCategoria(String nuevaCategoria) 
  {
  setState(() {
    seleccionCategoria = nuevaCategoria;
  });
  }

  @override
  Widget build(BuildContext context) {
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
      width: 350,
      child: Center
      (
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
          [
            Row
            (
              children: 
              [
                Spacer(),
                Text("Temporizador", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25, color: Color.fromRGBO(255, 0, 0, 1))),
                Spacer()
              ],
            ),
            Row
            (
              children: 
              [
                Spacer(),
                botonIzquierdoTemporizador("20", actualizaSeleccionTemporizador),
                botonCentralTemporizador("25", actualizaSeleccionTemporizador),
                botonDerechoTemporizador("30", actualizaSeleccionTemporizador),
                Spacer()
              ],
            ),
            Row
            (
              children: 
              [
                Spacer(),
                Text("Categoria", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25, color: Color.fromRGBO(255, 0, 0, 1),)),
                Spacer(),
              ],
            ),
            Row
            (
              children: 
              [
                Spacer(),
                botonIzquierdoCategoria("Dibus", actualizaSeleccionCategoria),
                botonDerechoCategoria("Anime", actualizaSeleccionCategoria),
                Spacer()
              ],
            ),
            Row
            (
              children: 
              [
                SizedBox(height: 20)
              ],
            )
          ],
        ),
      ),
    );
  }
}


botonIzquierdoTemporizador(String dato, Function actualiza)
{
  return
  ElevatedButton
  (
    style: ElevatedButton.styleFrom
    (
      backgroundColor: seleccionTemporizador == dato ? Color.fromRGBO(100, 100, 201, 1) : Color.fromRGBO(255, 255, 255, 1),
      foregroundColor: seleccionTemporizador == dato ? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(100, 100, 201, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))),

    ),
    onPressed:  () 
    {
      actualiza(dato);
    },
    child: Text(dato)
  );
}

botonCentralTemporizador(String dato, Function actualiza)
{
  return
  ElevatedButton
  (
    style: ElevatedButton.styleFrom
    (
      backgroundColor: seleccionTemporizador == dato ? Color.fromRGBO(100, 100, 201, 1) : Color.fromRGBO(255, 255, 255, 1),
      foregroundColor: seleccionTemporizador == dato ? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(100, 100, 201, 1),
      shape: RoundedRectangleBorder(),
    ),
    onPressed:  () 
    {
      actualiza(dato);
    },
    child: Text(dato)
  );
}

botonDerechoTemporizador(String dato, Function actualiza)
{
  return
  ElevatedButton
  (
    style: ElevatedButton.styleFrom
    (
      backgroundColor: seleccionTemporizador == dato ? Color.fromRGBO(100, 100, 201, 1) : Color.fromRGBO(255, 255, 255, 1),
      foregroundColor: seleccionTemporizador == dato ? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(100, 100, 201, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))),
    ),
    onPressed:  () 
    {
      actualiza(dato);
    },
    child: Text(dato)
  );
}

botonIzquierdoCategoria(String dato, Function actualiza)
{
  return
  ElevatedButton
  (
    style: ElevatedButton.styleFrom
    (
      backgroundColor: seleccionCategoria == dato ? Color.fromRGBO(100, 100, 201, 1) : Color.fromRGBO(255, 255, 255, 1),
      foregroundColor: seleccionCategoria == dato ? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(100, 100, 201, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))),
    ),
    onPressed:  () 
    {
      actualiza(dato);
    },
    child: Row(children: [Text(""),Image(image: AssetImage("imagenes/simba.png"),width: 80,height: 80,)])
  );
}

botonDerechoCategoria(String dato, Function actualiza)
{
  return
  ElevatedButton
  (
    style: ElevatedButton.styleFrom
    (
      backgroundColor: seleccionCategoria == dato ? Color.fromRGBO(100, 100, 201, 1) : Color.fromRGBO(255, 255, 255, 1),
      foregroundColor: seleccionCategoria == dato ? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(100, 100, 201, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))),
    ),
    onPressed:  () 
    {
      actualiza(dato);
    },
    child: Row(children: [Text(""),Image(image: AssetImage("imagenes/goku.png"),width: 80,height: 80,)])
  );
}

