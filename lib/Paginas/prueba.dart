import 'dart:async';
import 'dart:math';
import 'package:childhoo_memories_app/Canciones/dibujos.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

bool navegacion = true;
bool ocultaBotonJugar = true;
bool ocultaVideo = false;//
bool ocultaJuego = true;//
bool ocultaRespuestas = false;
bool ocultaBotonesVideo = true;//
bool pause = true;
bool corregirRespuesta = true;
bool responder = true;
bool repetir = false;
String respuestaP = "";
String respuestaC = "";
int tiempoTemporizador = 25;
int seleccionPeli = 0;
int seleccionCancion = 0;
int juegoRepetido = 0;
int cancionRepetida = 0;
int cancionRandom = 0;
int cancionJugadas = 0;
int cantidadDeCanciones= 130;
var numCancion = 0;
Dibujos canciones = listaCancionesDibujos;
double score = 0;
double volumen = 1.0;
double posicionVideo = 0.0;
List<int> cancionesParaJugar = [];
List<String> respuestasP = [];
List<String> respuestasC = [];


class Prueba extends StatefulWidget 
{
  static const routeName = 'prueba';
  @override
  PruebaEstado createState() => PruebaEstado();
}

class PruebaEstado extends State<Prueba> 
{
  late Timer temporizador;
  late VideoPlayerController controladorVideo = VideoPlayerController.asset("videos/${cancionRandom + 1}.MP4")..initialize().then((_)
    {
    });

  void primeraCancion() 
  {
    setState(() 
    {
      int a = 210;
      cancionRandom = Random().nextInt(cantidadDeCanciones);
      controladorVideo.dispose();
      controladorVideo = VideoPlayerController.asset("videos/${a}.MP4")..initialize().then((_)
      {
        if (volumen == 1.0)
        {
          volumen = volumen - 0.01;
          controladorVideo.setVolume(volumen);
        }
        else
        {
          volumen = volumen + 0.01;
          controladorVideo.setVolume(volumen);
        }
      });
      controladorVideo = VideoPlayerController.asset("videos/${a}.MP4")..initialize().then((_)
      {
        if (volumen == 1.0)
        {
          volumen = volumen - 0.01;
          controladorVideo.setVolume(volumen);
        }
        else
        {
          volumen = volumen + 0.01;
          controladorVideo.setVolume(volumen);
        }
      });

      if (listaCancionesDibujos.cancion![cancionRandom].repe != cancionRepetida)
      {
        primeraCancion();
      }
      else
      {
        setState(() 
        {
          listaCancionesDibujos.cancion![cancionRandom].repe = listaCancionesDibujos.cancion![cancionRandom].repe! + 1;

          List<String> listaP = [];
          listaP.add(listaCancionesDibujos.cancion![cancionRandom].resPv!);
          listaP.add(listaCancionesDibujos.cancion![cancionRandom].resPx1!);
          listaP.add(listaCancionesDibujos.cancion![cancionRandom].resPx2!);
          listaP.add(listaCancionesDibujos.cancion![cancionRandom].resPx3!);

          listaP.shuffle();
          respuestasP.clear();
          respuestasP.addAll(listaP);

          List<String> listaC = [];
          listaC.add(listaCancionesDibujos.cancion![cancionRandom].respCv!);
          listaC.add(listaCancionesDibujos.cancion![cancionRandom].respCx1!);
          listaC.add(listaCancionesDibujos.cancion![cancionRandom].respCx2!);
          listaC.add(listaCancionesDibujos.cancion![cancionRandom].respCx3!);

          listaC.shuffle();
          respuestasC.clear();
          respuestasC.addAll(listaC);
        });
      }
      
    });
  }
  

  @override
  void initState() 
  {
    super.initState();
    primeraCancion();    
  }

  @override
  Widget build(BuildContext context) 
  {

    void ocultaJugar() 
    {
      if (ocultaBotonJugar) 
      {
        setState(() 
        {
          ocultaBotonJugar = false;
          navegacion = false;
        });
      }
    }

    void muestraVideos() 
    {
      setState(() 
      {
        ocultaVideo = true;
        ocultaBotonesVideo = true;
      });  
    }

    void muestraJuego(bool valor) 
    {
      setState(() {ocultaJuego = valor;});
    }

    void actualizaSeleccionPeli(int peli) 
    {
      setState(()
      {
        seleccionPeli = peli;
      });
    }

    void actualizaSeleccionCancion(int cancion) 
    {
      setState(() 
      {
        seleccionCancion = cancion;
      });
    }
    
    void actualizaRespuestaP(String valor) 
    {
      setState(() 
      {
        respuestaP = valor;

      });  
    }
    void actualizaRespuestaC(String valor) 
    {
      setState(() 
      {
        respuestaC = valor;
      });  
    }

    void corregirCancion(bool valor) 
    {
      setState(() 
      {
        if (respuestaP != "" || respuestaC != "") 
        {         
          if (tiempoTemporizador == 0) 
          {
            if (respuestaP == listaCancionesDibujos.cancion![cancionRandom].resPv)
            {
              score = score + 0.5;
            }

            if (respuestaC == listaCancionesDibujos.cancion![cancionRandom].respCv)
            {
              score = score + 0.5;
            }
            tiempoTemporizador = 25;
            responder = false;
            corregirRespuesta = false;
          }

          if (tiempoTemporizador > 0) 
          {
            tiempoTemporizador = 0;
            responder = false;
            corregirRespuesta = false;
          }
        }
      });
    }

    void cambiaVolumen(double volumenActual) 
    {
      setState(() 
      {
        volumen = volumenActual;
        controladorVideo.setVolume(volumen);
      }); 
    }

    void moverseVideo(double segundo) 
    {
      setState(() 
      {
        posicionVideo = segundo;
        controladorVideo.seekTo(Duration(seconds: segundo.toInt()));
      });  
    }

    void pararVideoIcono(bool valor)
    {
      setState(() {
        pause = !valor;
      });
    }

  void iniciaTemporizador() 
  {
    temporizador = Timer.periodic(Duration(seconds: 1), (timer)
    {      
      setState(() 
      {
        if (tiempoTemporizador > 0) 
        {          
          tiempoTemporizador = tiempoTemporizador - 1;
        }
        
        if (tiempoTemporizador <= 0)
        {
          temporizador.cancel();
          corregirCancion(false);
        }
      });
    });
  }

  void cancionNueva() 
  {
    cancionRandom = Random().nextInt(cantidadDeCanciones);

    if (listaCancionesDibujos.cancion![cancionRandom].repe != cancionRepetida) 
    {
      cancionNueva();
    }
    else
    {
      setState(() 
      {
        listaCancionesDibujos.cancion![cancionRandom].repe = listaCancionesDibujos.cancion![cancionRandom].repe! + 1;

        List<String> listaP = [];
        listaP.clear();
        listaP.add(listaCancionesDibujos.cancion![cancionRandom].resPv!);
        listaP.add(listaCancionesDibujos.cancion![cancionRandom].resPx1!);
        listaP.add(listaCancionesDibujos.cancion![cancionRandom].resPx2!);
        listaP.add(listaCancionesDibujos.cancion![cancionRandom].resPx3!);

        listaP.shuffle();
        respuestasP.clear();
        respuestasP.addAll(listaP);
        respuestaP = listaCancionesDibujos.cancion![cancionRandom].resPv!;

        List<String> listaC = [];
        listaC.add(listaCancionesDibujos.cancion![cancionRandom].respCv!);
        listaC.add(listaCancionesDibujos.cancion![cancionRandom].respCx1!);
        listaC.add(listaCancionesDibujos.cancion![cancionRandom].respCx2!);
        listaC.add(listaCancionesDibujos.cancion![cancionRandom].respCx3!);

        listaC.shuffle();
        respuestasC.clear();
        respuestasC.addAll(listaC);
        respuestaC =  listaCancionesDibujos.cancion![cancionRandom].respCv!;
      });
    }
  }
    
    void siguienteVideo() 
    {
      setState(() 
      {
        numCancion = numCancion + 1;
        ocultaVideo = true;
        ocultaJuego = false;
        ocultaBotonesVideo = false;
        responder = true;
        seleccionPeli = 0;
        seleccionCancion = 0;
        tiempoTemporizador = 25;
        corregirRespuesta = true;
        ocultaRespuestas = false;
        respuestaP = "";
        respuestaC = "";
      });
      setState(() 
      {
        if (numCancion < 11) 
        {          
          if (volumen == 1.0) 
          {
            volumen = volumen - 0.01;
            controladorVideo.setVolume(volumen);
          }
          else
          {
            volumen = volumen + 0.01;
            controladorVideo.setVolume(volumen);
          }
          controladorVideo.dispose();
          controladorVideo = VideoPlayerController.asset("videos/${cancionRandom + 1}.MP4")..initialize().then((_)
          {
            if (volumen == 1.0)
            {
              volumen = volumen - 0.01;
              controladorVideo.setVolume(volumen);
            }
            else
            {
              volumen = volumen + 0.01;
              controladorVideo.setVolume(volumen);
            }
          });

          controladorVideo = VideoPlayerController.asset("videos/${cancionRandom + 1}.MP4")..initialize().then((_)
          {
            controladorVideo.setVolume(volumen);
            if (corregirRespuesta) 
            {
              moverseVideo(listaCancionesDibujos.cancion![cancionRandom].inicio!.toDouble());
              controladorVideo.play();
              ocultaJuego = true;
            }
            setState(() 
            {
              controladorVideo.addListener(()
              {
                if (controladorVideo.value.position.inSeconds > listaCancionesDibujos.cancion![cancionRandom].fin! && ocultaRespuestas == false) 
                {
                  corregirRespuesta = true;
                  ocultaRespuestas = true;
                  controladorVideo.pause();
                  moverseVideo(0.0);
                  muestraJuego(true);
                  iniciaTemporizador();
                }

                if (controladorVideo.value.duration.inSeconds == controladorVideo.value.position.inSeconds) 
                {
                  controladorVideo.pause();
                  moverseVideo(0.0);
                  pararVideoIcono(pause);
                }
              });
            });
          });
        }
        else
        {
          ocultaBotonJugar = true;
          repetir = true;
          navegacion = false;
          numCancion = 1;
          juegoRepetido = juegoRepetido + 1;
          score = 0;
          if (juegoRepetido == 21) 
          {
            cancionRepetida = cancionRepetida + 1;
          }
        }
      });
    }

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
        child: Column
        (
          children: 
          [
            Navegacion(),
            SizedBox(height: 20),
            jugarBoton(controladorVideo, ocultaJugar, siguienteVideo,),
            SizedBox(height: 10),

            Container
            ( height: 300,
              child: Container
              (
                child: Visibility
                (
                  visible: ocultaJuego,
                  child: Stack
                  (
                    children: 
                    [
                      VideoPlayer(controladorVideo),
                      Visibility(visible: ocultaVideo, child: Container(decoration: BoxDecoration(color: Color.fromRGBO(1, 1, 1, 1)),)),
                      Visibility
                      (visible: ocultaVideo, child: 
                        Center
                        (
                          child: Container
                          (
                            decoration: 
                            BoxDecoration
                            (
                              shape: BoxShape.circle, color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            height: 200,
                            child: Center(child: Text("$tiempoTemporizador",style: TextStyle(fontSize: 100,fontWeight: FontWeight.bold, color: Color.fromRGBO(75, 75, 201, 1)),)),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            Row
            (
              children: 
              [
                Spacer(),
                Visibility(visible: ocultaBotonesVideo, child: barraVideo(controladorVideo,moverseVideo,pararVideoIcono)),
                barraSonido(controladorVideo,cambiaVolumen),
                Spacer(),
              ],
            ),
            SizedBox(height: 20,),
            botonesJuego(corregirCancion, muestraVideos, siguienteVideo, cancionNueva),
            SizedBox(height: 20,),
            Visibility
            (
              visible: ocultaRespuestas,
              child: Container
              ( 
                constraints: BoxConstraints(minWidth: 500, maxWidth: 1920),
                decoration: BoxDecoration(color: Color.fromRGBO(100, 100, 201, 1),border: Border.all(color: Color.fromRGBO(0, 0, 0, 1),width: 3)),
                child: Center(child: Text( "Pelicula/Serie:", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.996),fontWeight: FontWeight.bold, fontSize: 25),))
              ),
            ),
            
            Visibility
            (
              visible: ocultaRespuestas,
              child: Column
              (
                
                children: 
                [
                  Row(children: [
                                  respuestas(respuestasP[0],1,actualizaSeleccionPeli,actualizaRespuestaP),
                                  respuestas(respuestasP[1],2,actualizaSeleccionPeli,actualizaRespuestaP)
                                ],),
                  Row(children: [
                                  respuestas(respuestasP[2],3,actualizaSeleccionPeli,actualizaRespuestaP),
                                  respuestas(respuestasP[3],4,actualizaSeleccionPeli,actualizaRespuestaP)
                                ],)
                ],
              ),
            ),

            Visibility
            (
              visible: ocultaRespuestas,
              child: Container
                  ( 
                    constraints: BoxConstraints(minWidth: 500, maxWidth: 1920),
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    decoration: BoxDecoration(color: Color.fromRGBO(100, 100, 201, 1),border: Border.all(color: Color.fromRGBO(0, 0, 0, 1),width: 3)),
                    child: Center(child: Text( "Cancion:", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.996),fontWeight: FontWeight.bold, fontSize: 25),))
                  ),
            ),

            Visibility
            (
              visible: ocultaRespuestas,
              child: Column
              (
                children: 
                [
                  Row(children: [
                                  respuestas(respuestasC[0],5,actualizaSeleccionCancion,actualizaRespuestaC),
                                  respuestas(respuestasC[1],7,actualizaSeleccionCancion,actualizaRespuestaC)
                                ],),
                  Row(children: [
                                  respuestas(respuestasC[2],6,actualizaSeleccionCancion,actualizaRespuestaC),
                                  respuestas(respuestasC[3],8,actualizaSeleccionCancion,actualizaRespuestaC)
                                ],)
                ],
              ),
            ),
            Spacer(),
          ]
        ),
      ),
    );
  }
}  

class Navegacion extends StatelessWidget 
{
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: 
      [
        Visibility(
          visible: navegacion,
          child: Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>
            [
              ElevatedButton
              (
                style: ElevatedButton.styleFrom
                (
                  backgroundColor: Color.fromRGBO(100, 100, 201, 1),
                  foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))),
                  fixedSize: Size(160, 40),
                ),
                onPressed: ()
                {
                  Navigator.pushReplacementNamed(context, "perfil");
                }, 
                child: Text("Perfil", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
              ),
          
              ElevatedButton
              (
                style: ElevatedButton.styleFrom
                (
                  backgroundColor: Color.fromRGBO(100, 100, 201, 1),
                  foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(),
                  fixedSize: Size(160, 40),
                ),
                  onPressed: () 
                  {
                    Navigator.pushReplacementNamed(context, "inicio");
                  }, 
                    child: Text("Inicio", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
              ),
          
              ElevatedButton
              (
                style: ElevatedButton.styleFrom
                (
                  backgroundColor: Color.fromRGBO(100, 100, 201, 1),
                  foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))),
                  fixedSize: Size(160, 40),
                ),
                  onPressed: () 
                  {
                    Navigator.pushReplacementNamed(context, "opciones");
                  }, 
                  child: Text("Opciones", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
              ),
            ],
          ),
        ),
      ],
    );
  }
}

jugarBoton(var video, Function oculta, Function empieza)
{
  return

  Row(
    children: 
    [
      Spacer(),
      Visibility(
        visible: ocultaBotonJugar != true,
        child: Row
        (
          children: 
          [
            Container
            (
              constraints: BoxConstraints(minWidth: 180, minHeight: 40),
              decoration: BoxDecoration(color: Color.fromRGBO(100, 100, 201, 1),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft: Radius.circular(10)),border: Border.all(color: Color.fromRGBO(1, 1, 1, 1))),
              child: Center(child: Text("Cancion: ",style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),fontSize: 40, fontWeight: FontWeight.bold),)),
            ),
            Container
            (
              constraints: BoxConstraints(minWidth: 100, minHeight: 40),
              // margin: EdgeInsets.fromLTRB(0, 1, 1, 1),
              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topRight: Radius.circular(10)),border: Border.all(color: Color.fromRGBO(1, 1, 1, 1))),
              child: Center(child: Row(
                children: 
                [
                  Text("${numCancion}",style: TextStyle(color: Color.fromRGBO(255, 0, 0, 1),fontSize: 40,fontWeight: FontWeight.bold),),
                  Text("/10",style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontSize: 40,fontWeight: FontWeight.bold),),
                ],
              )),
            ),
          ],
        ),
      ),
      Spacer(),
      Visibility
      (
        visible: ocultaBotonJugar,
        child: ElevatedButton
        (
          style: ElevatedButton.styleFrom
          (
            backgroundColor: Color.fromRGBO(100, 100, 201, 1),
            foregroundColor: Color.fromRGBO(255, 255, 255, 1),
          ),
          onPressed: ()
          {
            empieza();
            oculta();
          },
          child: Text(cambiaJugar(),style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
        )
      ),
      Spacer(),
      Visibility(
        visible: ocultaBotonJugar != true,
        child: Row
        (
          children: 
          [
            Container
            (
              constraints: BoxConstraints(minWidth: 60, minHeight: 40),
              margin: EdgeInsets.fromLTRB(1, 1, 0, 1), 
              decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft: Radius.circular(10)),border: Border.all(color: Color.fromRGBO(1, 1, 1, 1))),
              child: Center(child: Row(
                children: 
                [
                  Text("${score}",style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontSize: 40, fontWeight: FontWeight.bold),),
                ],
              )),
            ),
            Container
            (
              constraints: BoxConstraints(minWidth: 140, minHeight: 40),
              decoration: BoxDecoration(color: Color.fromRGBO(100, 100, 201, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topRight: Radius.circular(10)),border: Border.all(color: Color.fromRGBO(1, 1, 1, 1))),
              child: Center(child: Text("Score: ",style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),fontSize: 40,fontWeight: FontWeight.bold),)),
            ),
            
          ],
        ),
      ),
      Spacer(),
    ],
  );
}

respuestas(String respuesta, int posicion, Function seleccion, Function respuestaSeleccionada)
{
  return 
  Expanded
  (
    child: GestureDetector
    (
      onTap: () 
      {
        if (responder) 
        {
          seleccion(posicion);
          respuestaSeleccionada(respuesta);
        }
      },
      child: Container
      (
        constraints: BoxConstraints(minWidth: 500, maxWidth: 1920 ,minHeight: 70),
        decoration: BoxDecoration(color: seleccionRespuesta(posicion, respuesta),border: Border.all(color: Color.fromRGBO(1, 1, 1, 1),width: 3)), 
        child: Center
        (
        child: Text(respuesta, textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.992),fontWeight: FontWeight.bold, fontSize: 20,)) )
      ),
    ));
}

seleccionRespuesta(int posicion, String respuesta)
{
  if (posicion > 0 && posicion < 5 && corregirRespuesta == true) 
  {
    if (seleccionPeli == posicion)
    {
      return Color.fromRGBO(255, 251, 0, 1);
    }
    else
    {
      return Color.fromRGBO(255, 255, 255, 1);
    }
  }

  if (posicion > 0 && posicion < 5 && corregirRespuesta == false) 
  {
    if (seleccionPeli == posicion && listaCancionesDibujos.cancion![cancionRandom].resPv == respuestaP)
    {
      return Color.fromRGBO(0, 255, 34, 1);
    }
    if (seleccionPeli == posicion && listaCancionesDibujos.cancion![cancionRandom].resPv != respuestaP)
    {
      return Color.fromRGBO(255, 0, 0, 1);
    }
    else
    {
      return Color.fromRGBO(255, 255, 255, 1);
    }
  }

  if (posicion > 4 && posicion < 9 && corregirRespuesta == true) 
  {
    if (seleccionCancion == posicion)
    {
      return Color.fromRGBO(255, 251, 0, 1);
    }
    else
    {
      return Color.fromRGBO(255, 255, 255, 1);
    }
  }

  if (posicion > 4 && posicion < 9 && corregirRespuesta == false) 
  {
    if (seleccionCancion == posicion && listaCancionesDibujos.cancion![cancionRandom].respCv == respuestaC)
    {
      return Color.fromRGBO(0, 255, 34, 1);
    }
    if (seleccionCancion == posicion && listaCancionesDibujos.cancion![cancionRandom].respCv != respuestaC)
    {
      return Color.fromRGBO(255, 0, 0, 1);
    }
    else
    {
      return Color.fromRGBO(255, 255, 255, 1);
    }
  }
  
}

pauseVideo()
{
  if (pause) 
      {
        return  Icons.play_arrow_rounded;
      }
      else
      {
        return Icons.pause;        
      }
}

barraVideo(var video, Function moverse, Function parar)
{
  return Row(
    children: 
    [
      ElevatedButton( onPressed: ()
      {
        if (pause) 
        {
          video.play();
          parar(pause);
        }
        else 
        {
          video.pause();
          parar(pause);
        };
      }, 
        child: Icon(pauseVideo()),
        style: ElevatedButton.styleFrom
        (
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          fixedSize: Size(10, 30),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)))
        ),),
      
      Container
      (
        constraints: BoxConstraints(maxWidth: 180, maxHeight: 32),
        decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1)),
        child: Slider
        (
          value: posicionVideo,
          min: 0.0, 
          max: video.value.duration.inSeconds,
          onChanged: (value) => (moverse(value))
          ),
      ),
        ElevatedButton(onPressed: (){video.seekTo(Duration(seconds: 0));moverse(0);},
        child: Icon(Icons.replay_outlined), 
        style: ElevatedButton.styleFrom
        (backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        fixedSize: Size(10, 30),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)))),),
    ],
  );
}

muted()
{
  if (volumen <= 0) 
      {
        return Icons.volume_mute;
      }
      else
      {
        return  Icons.volume_down;
      }
}

barraSonido(var video, Function cambioVolumen)
{
  return Row(
    children: 
    [
      Container(
        constraints: BoxConstraints(maxWidth: 150, maxHeight: 32),
        decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))),
        child: Slider
        (
          value: volumen, 
          min: 0.0, 
          max: 1.0,
          onChanged: (value)
          {
            cambioVolumen(value);
          },
        ),
      ),
      ElevatedButton(onPressed: ()
      {
        
        if (volumen != 0) 
        {
          cambioVolumen(0.0);
        }
        else
        {
          cambioVolumen(volumen);
        }
      },
       style: ElevatedButton.styleFrom
        (backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        fixedSize: Size(10, 30),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)))),
        child: Icon(muted())),
    ],
  );
}

cambiaCorregir()
{
  if (corregirRespuesta) 
  {
    return "Corregir";
  } 
  else 
  {
    return "Siguiente";
  }
}

cambiaJugar()
{
  if (repetir == false) 
  {
    return "Jugar";
  } 
  else 
  {
    return "Repetir";
  }
}

botonesJuego(Function corregir, Function verVideo, Function siguienteVideo, Function cancionNueva)
{
  return Row(
    children: 
    [
      Spacer(),
      Visibility(
        visible: ocultaRespuestas,
        child: ElevatedButton
        (
          style: ElevatedButton.styleFrom
          (
            backgroundColor: Color.fromRGBO(100, 100, 201, 1),
          ),
          onPressed: ()
          {
            if (corregirRespuesta) 
            {
              corregir(corregirRespuesta);
            } 
            else 
            {
              cancionNueva();
              siguienteVideo();
            }
          },
          child: Text(cambiaCorregir(), style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 35, fontWeight: FontWeight.bold))
        ),
      ),
      SizedBox(width: 20,),
      Visibility(
        visible: corregirRespuesta == false,
        child: ElevatedButton
        (
          style: ElevatedButton.styleFrom
          (
            backgroundColor: Color.fromRGBO(100, 100, 201, 1),
          ),
          onPressed: ()
          {
            verVideo();
          },
          child: Text("Ver video", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 35, fontWeight: FontWeight.bold)),
        ),
      ),
      Spacer()

    ],
  );
}