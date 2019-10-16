import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infogestion/extras/appTheme.dart';
import 'package:infogestion/extras/globals.dart';
import 'package:infogestion/pages/admin/crearUsuario.dart';
import 'package:infogestion/pages/admin/listaPdfs.dart';
import 'package:infogestion/pages/admin/listaUsuarios.dart';
import 'package:http/http.dart' as http;

class AdminPage extends StatefulWidget {
  
  AdminPage(
    {
      Key key ,
      
    }
  ) : super(key: key );
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget contenido;

  @override
  void initState() {
    super.initState();
    setState(() {
      contenido = ListUsuarios(
        cantData: 0,
      );
    });
    
    _getUsuario();
    _getPdfs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(FontAwesomeIcons.userFriends, size: 20, color: Colors.white,),
            Icon(FontAwesomeIcons.userPlus, size: 20, color: Colors.white),
            Icon(FontAwesomeIcons.filePdf, size: 20, color: Colors.white),
            
            
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
                  _getUsuario();
                  setState(() {
                   contenido = ListUsuarios(
                     data: dataUsuarios,
                     cantData: cantDataUsuarios,
                   ); 
                  });
                  break;
                case 1:
                  setState(() {
                   contenido = CrearUsuario(); 
                  });
                  break;
                default:
                _getPdfs();
                setState(() {
                   contenido = ListPdfs(
                     cantData: cantDataPdf,
                     data: dataPdf,
                   ); 
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
  
  var dataUsuarios;
  int cantDataUsuarios = 0;
  _getUsuario() async{
    String url =
          "$urlAdmin/mostrarUsuarios";
    print(url);
    var response = await http.post(url, body: {
                        "api_token" : "$globaltoken",
                      });

      
    print(response.body);
    
    if (response.statusCode == 200) {

      final map         = json.decode(response.body);
      final result       = map["result"];
      
      setState(() {
       this.dataUsuarios = result;
       this.cantDataUsuarios = this.dataUsuarios.length;
       this.contenido = ListUsuarios(
         data: this.dataUsuarios,
         cantData: this.cantDataUsuarios,
       );

      });


    }else{
      
    }

  }
  

  var dataPdf;
  int cantDataPdf = 0;
  _getPdfs() async{
    String url =
          "$urlAdmin/mostrarPdfs";
    print(url);
    var response = await http.post(url, body: {
                        "api_token" : "$globaltoken",
                      });

      
    print(response.body);
    if (response.statusCode == 200) {

      final map         = json.decode(response.body);
      final result       = map["result"];
      
      setState(() {
        this.dataPdf = result;
        this.cantDataPdf = this.dataPdf.length;
        
      });


    }else{
      
    }

  }
}