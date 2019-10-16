import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infogestion/extras/appTheme.dart';
import 'package:infogestion/extras/globals.dart';
import 'package:infogestion/pages/admin/asignarPdf.dart';
import 'package:infogestion/pages/admin/editarUsuario.dart';
import 'package:infogestion/pages/admin/listaPdfs.dart';
import 'package:http/http.dart' as http;

class EditarPage extends StatefulWidget {
  final String nombreUsuario;
  final int idUsuario;
  final int tipoUsuario;
  EditarPage(
    {
      Key key ,
      this.nombreUsuario,
      this.idUsuario,
      this.tipoUsuario
    }
  ) : super(key: key );


  @override
  _EditarPageState createState() => _EditarPageState();
}

class _EditarPageState extends State<EditarPage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget contenido;

  var dataPdfAsignados;
  int cantDataPdfAsignados = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
     contenido = AsignarPdf(
       idUsuario: widget.idUsuario,
       nombreUsuario: widget.nombreUsuario,
       dataPdfDisponibles: dataPdfDisponibles,
       cantDataPdfDisponibles: cantDataPdfDisponibles,
       
       cantDataPdfAsignados: cantDataPdfAsignados,
       dataPdfAsignados: dataPdfAsignados,

     ); 
    });
    _getPdfsDisponiblesAsignados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(FontAwesomeIcons.list, size: 20, color: Colors.white,),
            Icon(FontAwesomeIcons.userEdit, size: 20, color: Colors.white),
            
          ],
          color: AppTheme.primary,
          buttonBackgroundColor: AppTheme.secondary,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            print(index);
            switch (index) {
                case 0:
                  _getPdfsDisponiblesAsignados();
                  setState(() {
                   contenido = AsignarPdf(
                      idUsuario: widget.idUsuario,
                      nombreUsuario: widget.nombreUsuario,
                      dataPdfDisponibles: dataPdfDisponibles,
                      cantDataPdfDisponibles: cantDataPdfDisponibles,

                      cantDataPdfAsignados: cantDataPdfAsignados,
                      dataPdfAsignados: dataPdfAsignados,
                   ); 
                  });
                  break;
                case 1:
                  setState(() {
                   contenido = EditarUsuario(
                     idUsuario      : "${widget.idUsuario}",
                     tipoUsuario    : "${widget.tipoUsuario}",
                     nombreUsuario  : "${widget.nombreUsuario}",
                   ); 
                  });
                  break;
                default:
                setState(() {
                   contenido = ListPdfs(); 
                  });
              }
            setState(() {
              _page = index;
              
            });
          },
        ),
        body: contenido
      );
    
  }
  
  var dataPdfDisponibles;
  int cantDataPdfDisponibles = 0;
  _getPdfsDisponiblesAsignados() async{
    String url =
          "$urlAdmin/mostrarPdfsDisponiblesAsignados";
    print(url);
    var response = await http.post(url, body: {
                        "api_token" : "$globaltoken",
                        "idUsuario" : "${widget.idUsuario}"
                      });

      
    print(response.body);
    if (response.statusCode == 200) {

      final map                   = json.decode(response.body);
      final estadoPdfsDisponibles = map["estadoPdfsDisponibles"];
      final estadoPdfsAsignados   = map["estadoPdfsAsignados"];
      final pdfsDisponibles       = map["pdfsDisponibles"];
      final pdfsAsignados         = map["pdfsAsignados"];
      
      setState(() {
          
          if(estadoPdfsDisponibles){
            this.dataPdfDisponibles = pdfsDisponibles;
            this.cantDataPdfDisponibles = this.dataPdfDisponibles.length;
          }

          if(estadoPdfsAsignados){
            this.dataPdfAsignados = pdfsAsignados;
            this.cantDataPdfAsignados = this.dataPdfAsignados.length;
          }

          this.contenido = AsignarPdf(
            idUsuario: widget.idUsuario,
            nombreUsuario: widget.nombreUsuario,
            dataPdfAsignados: this.dataPdfAsignados,
            cantDataPdfAsignados: this.cantDataPdfAsignados,

            dataPdfDisponibles: this.dataPdfDisponibles,
            cantDataPdfDisponibles: this.cantDataPdfDisponibles,
          );
      });


    }else{
      
    }

  }
  
}