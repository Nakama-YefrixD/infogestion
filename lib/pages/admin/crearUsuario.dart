import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infogestion/extras/appTheme.dart';
import 'package:infogestion/extras/globals.dart';
import 'package:infogestion/login.dart';
import 'package:infogestion/pages/admin/adminPage.dart';
import 'package:infogestion/widgets/appBarWidget.dart';
import 'package:http/http.dart' as http;
import 'package:infogestion/widgets/cargando.dart';
import 'package:infogestion/widgets/modals.dart';

class CrearUsuario extends StatefulWidget {
  CrearUsuario(
    {
      Key key
    }
  ) : super(key: key );
  @override
  CrearUsuarioState createState() => CrearUsuarioState();
}

class CrearUsuarioState extends State<CrearUsuario> {
  
  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 0));
    return true;
  }

  bool ocultarContrasena = true;
  bool ocultarConfirmacionContrasena = true;
  bool esUsuario = true;

  String username;
  String contrasena;
  String confirmarContrasena;
  
  Color adminActivado = AppTheme.semiTransparente;
  Color usuarioActivado = AppTheme.darkerText;

  @override
  Widget build(BuildContext context) {
    
    
    return WillPopScope(
      onWillPop: (){
        
      },
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBarWidget(
              titulo: "Crear Usuario",
              icono: Icon(FontAwesomeIcons.powerOff),
              press: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (BuildContext context ) => LoginPage()
                  )
                );
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox();
                  } else {
                    return Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 0.5),
                          child: ListView(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 50.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'DATOS DEL NUEVO USUARIO',
                                      style: new TextStyle(
                                        fontSize: 22,
                                        color: AppTheme.darkText,
                                        fontWeight: FontWeight.w700,
                                      )
                                    ),
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Card(
                                            elevation: 2.0,
                                            color: AppTheme.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            
                                            child: Container(
                                              width: 380.0,
                                              height: 360.0,
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                                    child: TextField(
                                                      onChanged: (texto){
                                                        setState(() {
                                                          username = texto; 
                                                        });
                                                      },
                                                      keyboardType: TextInputType.text,
                                                      textCapitalization: TextCapitalization.words,
                                                      style: TextStyle(
                                                          fontFamily: AppTheme.fontName,
                                                          fontSize: 16.0,
                                                          color: Colors.black),
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        icon: Icon(
                                                          FontAwesomeIcons.user,
                                                          color: Colors.black,
                                                        ),
                                                        hintText: "Username*",
                                                        hintStyle: TextStyle(
                                                            fontFamily: AppTheme.fontName,
                                                            fontSize: 16.0
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 250.0,
                                                    height: 1.0,
                                                    color: Colors.grey[400],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                                    child: TextField(
                                                      onChanged: (texto){
                                                        setState(() {
                                                          contrasena = texto; 
                                                        });
                                                      },
                                                      obscureText: ocultarContrasena,
                                                      style: TextStyle(
                                                          fontFamily: AppTheme.fontName,
                                                          fontSize: 16.0,
                                                          color: Colors.black),
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        icon: Icon(
                                                          FontAwesomeIcons.lock,
                                                          color: Colors.black,
                                                        ),
                                                        hintText: "Contraseña*",
                                                        hintStyle: TextStyle(
                                                            fontFamily: AppTheme.fontName, 
                                                            fontSize: 16.0
                                                        ),
                                                        suffixIcon: IconButton(
                                                          onPressed: (){
                                                            setState(() {
                                                             if(ocultarContrasena){
                                                                ocultarContrasena = false;
                                                             }else{
                                                                ocultarContrasena = true;
                                                             }
                                                            });
                                                          },
                                                          icon: Icon(
                                                              ocultarContrasena
                                                                ? FontAwesomeIcons.eye
                                                                : FontAwesomeIcons.eyeSlash,
                                                            size: 15.0,
                                                            color: Colors.black,
                                                          ),
                                                        )
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 250.0,
                                                    height: 1.0,
                                                    color: Colors.grey[400],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                                    child: TextField(
                                                      onChanged: (texto){
                                                        setState(() {
                                                            confirmarContrasena = texto;   
                                                        });
                                                      },
                                                      obscureText: ocultarConfirmacionContrasena,
                                                      style: TextStyle(
                                                          fontFamily: AppTheme.fontName,
                                                          fontSize: 16.0,
                                                          color: Colors.black),
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        icon: Icon(
                                                          FontAwesomeIcons.lock,
                                                          color: Colors.black,
                                                        ),
                                                        hintText: "Confirmar contraseña*",
                                                        hintStyle: TextStyle(
                                                            fontFamily: AppTheme.fontName, 
                                                            fontSize: 16.0
                                                        ),
                                                        suffixIcon: IconButton(
                                                          onPressed: (){
                                                            setState(() {
                                                             if(ocultarConfirmacionContrasena){
                                                                ocultarConfirmacionContrasena = false;
                                                             }else{
                                                                ocultarConfirmacionContrasena = true;
                                                             }
                                                            });
                                                          },
                                                          icon: Icon(
                                                            ocultarConfirmacionContrasena
                                                                ? FontAwesomeIcons.eye
                                                                : FontAwesomeIcons.eyeSlash,
                                                            size: 15.0,
                                                            color: Colors.black,
                                                          ),
                                                        )
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 250.0,
                                                    height: 1.0,
                                                    color: Colors.grey[400],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0, bottom: 20.0, left: 25.0, right: 25.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Text(
                                                          'ADMIN',
                                                          style: new TextStyle(
                                                            fontSize: 15,
                                                            color: adminActivado,
                                                            fontWeight: FontWeight.w700,
                                                          )
                                                        ),
                                                        Switch(
                                                          value: esUsuario,
                                                          activeColor: AppTheme.primary,
                                                          onChanged: (valor){
                                                            setState(() {
                                                              esUsuario = valor;
                                                              if(valor){
                                                                adminActivado = AppTheme.semiTransparente;
                                                                usuarioActivado = AppTheme.darkerText;
                                                              }else{
                                                                usuarioActivado = AppTheme.semiTransparente;
                                                                adminActivado = AppTheme.darkerText;
                                                              }
                                                            });
                                                          },
                                                        ),
                                                        Text(
                                                          'USUARIO',
                                                          style: new TextStyle(
                                                            fontSize: 15,
                                                            color: usuarioActivado,
                                                            fontWeight: FontWeight.w700,
                                                          )
                                                        ),
                                                      ],
                                                    )
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 340.0),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: AppTheme.darkText,
                                                offset: Offset(1.0, 6.0),
                                                blurRadius: 10.0,
                                              ),
                                              BoxShadow(
                                                color: AppTheme.darkText,
                                                offset: Offset(1.0, 6.0),
                                                blurRadius: 5.0,
                                              ),
                                            ],
                                            color: AppTheme.primary
                                          ),
                                          child: MaterialButton(
                                              // highlightColor: AppTheme.primary,
                                              splashColor: AppTheme.darkText,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 10.0, horizontal: 42.0),
                                                child: Text(
                                                  "REGISTRAR",
                                                  style: new TextStyle(
                                                    fontSize: 20,
                                                    color: AppTheme.white,
                                                    fontWeight: FontWeight.w700,
                                                  )
                                                ),
                                              ),
                                              onPressed: () {
                                                _validarCampos();
                                              }
                                            ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ]
        )
      )
    );
  }

  _validarCampos(){

    if(contrasena != confirmarContrasena){
      modalMensaje.mensaje(context, "Las contraseñas no son las mismas.");
    }else if(username == null){
      modalMensaje.mensaje(context, "El campo de username es necesario.");
    }else if(contrasena == null){
      modalMensaje.mensaje(context, "El campo de contraseña es necesario.");
    }else if(confirmarContrasena == null){
      modalMensaje.mensaje(context, "El campo de confirmar contraseña es necesario.");
    }else if(username.length < 4){
      modalMensaje.mensaje(context, "El username debe tener mas de 4 caracteres.");
    }else if(contrasena.length < 4){
      modalMensaje.mensaje(context, "La contraseña debe tener mas de 4 caracteres.");
    }else{
      carga.cargando(context, "REGISTRANDO USUARIO");
      _register();
    }
  }

  _register() async{
    String url =
          "$urlAdmin/registrarUsuario";
    
    print(url);
    var response = await http.post(url, body: {
                        "api_token" : "$globaltoken",
                        "username" : "$username",
                        "contrasena" : "$contrasena",
                        "tipo" : "$esUsuario",
                      });

      
    print(response.body);
    
    if (response.statusCode == 200) {
      Navigator.of(context).pop();

      final respuesta = response.body;

      if(respuesta == "true"){
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (BuildContext context ) => AdminPage(
              
            )
          )
        );
      }else{
        modalMensaje.mensaje(context, "El usuario ya existe");
      }
    }else{
      Navigator.of(context).pop();
      modalMensaje.mensaje(context, "Servidor caido");
    }

  }

}