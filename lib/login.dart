import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infogestion/extras/appTheme.dart';
import 'package:infogestion/extras/globals.dart';
import 'package:infogestion/pages/admin/adminPage.dart';
import 'package:infogestion/pages/admin/prueba/web.client.dart';
import 'package:infogestion/pages/personal/listaPdfs.dart';
import 'package:infogestion/widgets/logo.dart';
import 'package:infogestion/widgets/cargando.dart';
import 'package:infogestion/widgets/modals.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: (){

        },
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20.0 , top: 100.0),
                child: LogoImg(),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    bottomLeft: const  Radius.circular(10.0),
                    bottomRight: const  Radius.circular(10.0),
                    topLeft: const  Radius.circular(10.0),
                    topRight: const  Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0, // has the effect of softening the shadow
                      // spreadRadius: 2.0, // has the effect of extending the shadow
                      
                    )
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Usuario',
                      style: new TextStyle(
                        fontSize: 14,
                        color: AppTheme.darkText,
                        fontWeight: FontWeight.w400,
                      )
                    ),
                    Container(
                      child: TextField(
                        onChanged: (value){
                          setState(() {
                            username = value;
                          });
                        },
                        style: new TextStyle(
                          fontSize: 16,
                          color: AppTheme.darkText,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          icon: Icon(FontAwesomeIcons.user)
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.0),
                    ),
                    Text(
                      'Contraseña',
                      style: new TextStyle(
                        fontSize: 14,
                        color: AppTheme.darkText,
                        fontWeight: FontWeight.w400,
                      )
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: TextField(
                        onChanged: (value){
                          setState(() {
                            contrasena = value;
                          });
                        },
                        style: new TextStyle(
                          fontSize: 16,
                          color: AppTheme.darkText,
                          fontWeight: FontWeight.w400,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(FontAwesomeIcons.unlock)
                        )
                      )
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.0),
              ),
              new RaisedButton(
                child: new Text("Iniciar sesión", 
                  style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.white,
                    fontWeight: FontWeight.w700,
                  )
                ), 
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: AppTheme.primary,
                onPressed: (){
                  
                  _login();
                  
                  // Navigator.push(
                  //   context, 
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context ) => Download(
                  //     )
                  //   )
                  // );
                },
              ),

              new Padding(
                padding: const EdgeInsets.all(5.0),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Text(
          'Servicios Contables y Tributarios', 
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
      )
    );
  }



  String username;
  String contrasena;
  String token;
  _login() async{
    
    String url =
          "$urlGlobal/loginApi";

    if(username == null || username == ""){
      modalMensaje.mensaje(context, "El campo usuario no puede estar vacio.");
    }else if(contrasena == "" || contrasena == null){
      modalMensaje.mensaje(context, "La contraseña es necesaria.");
    }else{
      carga.cargando(context, "Iniciando sesión");
      var response = await http.post(url, body: {
                        "username": username,
                        "contrasena": contrasena,
                      });
                      
      print(response.body);
      if (response.statusCode == 200) {
        final map         = json.decode(response.body);
        final code        = map["code"];
        final token       = map["api_token"];
        final id          = map["id"];
        final tipoUsuario = map['tipoUsuario'];
        final resultUsuario = map['resultUsuario'];

        
        if(code == true){
          setState(() {
            this.token = token;
            globalId          = "$id";
            globaltoken       = "$token";
            globalTipoUsuario = "$tipoUsuario";
          });

          switch (tipoUsuario) {
            case 1:
            Navigator.of(context).pop();
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (BuildContext context ) => AdminPage(
                  
                )
              )
            );
            break;
            case 2:
              Navigator.of(context).pop();
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (BuildContext context ) => ListaPdf(
                    
                  )
                )
              );
              break;
            default:
              Navigator.of(context).pop();
              modalMensaje.mensaje(context, "Usuario o contraseña incorrecta.");
          }
        }else{
          Navigator.of(context).pop();
          modalMensaje.mensaje(context, "Usuario o contraseña incorrecta.");
        }
      }else{
        Navigator.of(context).pop();
        modalMensaje.mensaje(context, "Usuario o contraseña incorrecta.");
      }
    }
  }
}