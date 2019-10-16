import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infogestion/extras/appTheme.dart';
import 'package:infogestion/extras/globals.dart';
import 'package:infogestion/login.dart';
import 'package:infogestion/pages/admin/editarPage.dart';
import 'package:infogestion/widgets/appBarWidget.dart';
import 'package:http/http.dart' as http;

class ListUsuarios extends StatefulWidget {
  
  var data;
  final int cantData;
  ListUsuarios(
    {
      Key key ,
      this.data,
      this.cantData
    }
  ) : super(key: key );
  @override
  _ListUsuariosState createState() => _ListUsuariosState();
}

class _ListUsuariosState extends State<ListUsuarios> {

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 0));
    return true;
  }
  
  String textoBusqueda = '';
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
              titulo: "Lista de usuarios",
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
                        
                        // if(loading)
                        // CargandoData(),
                        Padding(
                          padding: EdgeInsets.only(top: 0.5),
                          child: ListView(
                            children: <Widget>[
                              // if(buscar)
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(left:5.0, right: 5.0),
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.only(left:5.0, right: 5.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          hintText: 'Buscar'
                                        ),
                                        onChanged: (text){
                                          setState(() {
                                              textoBusqueda = text;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                for(int cont=0; cont < widget.cantData; cont++)
                                  if(widget.data[cont]['username'].indexOf(textoBusqueda.toUpperCase()) != -1 || widget.data[cont]['username'].indexOf(textoBusqueda.toLowerCase()) != -1  )
                                  usuarios(
                                    context,
                                    widget.data[cont]['tipo_id'],
                                    widget.data[cont]['id'],
                                    "${widget.data[cont]['username']}"
                                  )
                              // for(int cont=0; cont < cantOS; cont++)
                              //   if(data[cont]['documento'].indexOf(textoBusqueda.toUpperCase()) != -1 || data[cont]['documento'].indexOf(textoBusqueda.toLowerCase()) != -1  )
                              //   _buildOrdenesServicio(
                              //     data[cont]['id'],
                              //     "${data[cont]['documento']}",
                              //     "${data[cont]['usuario']}",
                              //     "${data[cont]['fechaCreada']}",
                              //     data[cont]['estado'],
                                  
                              //   ),
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


  
  String myString;
  
  Widget usuarios(BuildContext context, int tipoUsuario,int idUsuario, String nombreUsuario){
    
    return Container(
      child: Dismissible(
        // movementDuration: Duration(milliseconds: 5}000),
        onDismissed: (direction){
          print(direction);
          if(direction == DismissDirection.endToStart){
            _eliminarUsuario(idUsuario);
          }else{
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (BuildContext context ) => EditarPage(
                  nombreUsuario : nombreUsuario,
                  idUsuario     : idUsuario,
                  tipoUsuario   : tipoUsuario,
                )
              )
            );
          }
        },
        
        background: Container(
          width: 1.0,
          height: 5.0,
          color: Colors.green,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  FontAwesomeIcons.check,
                  color: AppTheme.white,
                ),
              )
            ],
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: TextDirection.rtl,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  FontAwesomeIcons.trash,
                  color: AppTheme.white,
                ),
              )
            ],
          ),
        ),
        key: ValueKey(myString),
        child: Container(
          color: AppTheme.white,
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Container(
              // width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 55.0,
                    height: 55.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/img/usuario.png')
                      )
                    ),
                  ),
                  Expanded(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '',
                          style: new TextStyle(
                            fontSize: 14,
                            color: AppTheme.darkText,
                            fontWeight: FontWeight.w400,
                          )
                        ),
                        Text(
                          '$nombreUsuario',
                          style: new TextStyle(
                            fontSize: 14,
                            color: AppTheme.darkText,
                            fontWeight: FontWeight.w400,
                          )
                        ),
                      ],
                    )
                  ),
                  // Container(
                    
                  //   padding: EdgeInsets.symmetric(
                  //     // horizontal: 5.0,
                  //     vertical: 2.0
                  //   ),
                  //   child: FlatButton(
                  //     onPressed: (){

                  //     },
                  //     color: Colors.red,
                  //     shape: CircleBorder(),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(10.0),
                  //       child: Icon(
                  //         FontAwesomeIcons.trash,
                  //         color: AppTheme.white,
                  //       )
                  //     )
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        )
      )
    );
  }

  _eliminarUsuario(int idUsuario) async{
    String url =
          "$urlAdmin/eliminarUsuario";
    print(url);
    var response = await http.post(url, body: {
                        "api_token" : "$globaltoken",
                        "idUsuario" : "$idUsuario",
                      });

    
    print(response.body);
    
  }
}