import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infogestion/extras/appTheme.dart';
import 'package:infogestion/extras/globals.dart';
import 'package:infogestion/pages/admin/adminPage.dart';
import 'package:infogestion/pages/admin/editarPage.dart';
import 'package:infogestion/widgets/appBarWidget.dart';
import 'package:http/http.dart' as http;
import 'package:infogestion/widgets/cargando.dart';

class AsignarPdf extends StatefulWidget {
  final int idUsuario;
  final String nombreUsuario;
  var dataPdfDisponibles;
  final int cantDataPdfDisponibles;
  var dataPdfAsignados;
  final int cantDataPdfAsignados;


  AsignarPdf(
    {
      Key key ,
      this.idUsuario,
      this.nombreUsuario,
      this.dataPdfDisponibles,
      this.cantDataPdfDisponibles,

      this.dataPdfAsignados,
      this.cantDataPdfAsignados
    }
  ) : super(key: key );


  @override
  _AsignarPdfState createState() => _AsignarPdfState();
}

class _AsignarPdfState extends State<AsignarPdf> {
  
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
              titulo: "Control de PDFS",
              icono: Icon(FontAwesomeIcons.arrowLeft),
              press: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (BuildContext context ) => AdminPage(
                    )
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
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.0),
                                color: AppTheme.white,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                                                '${widget.nombreUsuario}',
                                                style: new TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.darkText,
                                                  fontWeight: FontWeight.w400,
                                                )
                                              ),
                                            ],
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
                                Padding(
                                  padding: EdgeInsets.only(left:10.0, right: 10.0, top: 10.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      
                                    },
                                    child: Container(
                                      color: AppTheme.primary,
                                      padding: EdgeInsets.all(3.0),
                                      child: Center(
                                        child: Text(
                                          'PDFS ASIGNADOS', 
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: AppTheme.white,
                                          )
                                        ),
                                      ),
                                    )
                                  ),
                                ),
                                for(int cont=0; cont < widget.cantDataPdfAsignados ; cont++)
                                  if(widget.dataPdfAsignados[cont]['nombre'].indexOf(textoBusqueda.toUpperCase()) != -1 || widget.dataPdfAsignados[cont]['nombre'].indexOf(textoBusqueda.toLowerCase()) != -1  )
                                  cajas(context,"${widget.dataPdfAsignados[cont]['id']}", "${widget.dataPdfAsignados[cont]['nombre']}", true),
                                
                                Padding(
                                  padding: EdgeInsets.only(left:10.0, right: 10.0, top: 10.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      
                                    },
                                    child: Container(
                                      color: Colors.green,
                                      padding: EdgeInsets.all(3.0),
                                      child: Center(
                                        child: Text(
                                          'PDFS DISPONIBLES', 
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: AppTheme.white,
                                          )
                                        ),
                                      ),
                                    )
                                  ),
                                ),
                                for(int cont=0; cont < widget.cantDataPdfDisponibles ; cont++)
                                  if(widget.dataPdfDisponibles[cont]['nombre'].indexOf(textoBusqueda.toUpperCase()) != -1 || widget.dataPdfDisponibles[cont]['nombre'].indexOf(textoBusqueda.toLowerCase()) != -1  )
                                    cajas(
                                      context,
                                      "${widget.dataPdfDisponibles[cont]['id']}",
                                      "${widget.dataPdfDisponibles[cont]['nombre']}",
                                      false
                                    ),
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
  
  Widget cajas(BuildContext context, String idPdf,String nombre ,bool asignado){
    Color btnColor;
    String textoBtn;
    if(asignado){
      btnColor = Colors.red;
      textoBtn = "Designar";

    }else{
      btnColor = AppTheme.secondary;
      textoBtn = "Asignar";
    }

    return Container(
        // padding: EdgeInsets.all(10.0),
        color: AppTheme.white,
        width: MediaQuery.of(context).size.width,        
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
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/img/pdf.png')
                      )
                    ),
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
                        '$nombre',
                        style: new TextStyle(
                          fontSize: 14,
                          color: AppTheme.darkText,
                          fontWeight: FontWeight.w400,
                        )
                      ),
                    ],
                  )
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 2.0
                  ),
                  child: FlatButton(
                    onPressed: 
                    asignado
                    ?()
                    {
                      carga.cargando(context, "Desasignando PDF");
                      _designar(idPdf);
                    }
                    :(){
                      carga.cargando(context, "Asignando PDF");
                      _asignar(idPdf);
                    },
                    color: btnColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        '$textoBtn',
                        style: new TextStyle(
                          fontSize: 10,
                          color: AppTheme.white,
                          fontWeight: FontWeight.w700,
                        )
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }

  _designar(String idPdf) async{
    String url =
          "$urlAdmin/designarPdf";
    print(url);
    var response = await http.post(url, body: {
                        "api_token" : "$globaltoken",
                        "idUsuario" : "${widget.idUsuario}",
                        "idPdf"     : "$idPdf"
                      });

      
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (BuildContext context ) => EditarPage(
            nombreUsuario: widget.nombreUsuario,
            idUsuario: widget.idUsuario
          )
        )
      );

    }else{
      
    }

  }

  _asignar(String idPdf) async{
    String url =
          "$urlAdmin/asignarPdf";
    print(url);
    var response = await http.post(url, body: {
                        "api_token" : "$globaltoken",
                        "idUsuario" : "${widget.idUsuario}",
                        "idPdf"     : "$idPdf"
                      });

      
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (BuildContext context ) => EditarPage(
            nombreUsuario: widget.nombreUsuario,
            idUsuario: widget.idUsuario
          )
        )
      );

    }else{
      
    }

  }


}