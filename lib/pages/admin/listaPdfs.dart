import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infogestion/extras/appTheme.dart';
import 'package:infogestion/extras/globals.dart';
import 'package:infogestion/login.dart';
import 'package:infogestion/pages/admin/verPdf/verPdf.dart';
import 'package:infogestion/widgets/appBarWidget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:infogestion/widgets/cargando.dart';

class ListPdfs extends StatefulWidget {
  
  var data;
  final int cantData;
  ListPdfs(
    {
      Key key ,
      this.data,
      this.cantData
    }
  ) : super(key: key );

  @override
  _ListPdfsState createState() => _ListPdfsState();
}

class _ListPdfsState extends State<ListPdfs> {

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
              titulo: "Lista de PDFs",
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
                                  if(widget.data[cont]['nombre'].indexOf(textoBusqueda.toUpperCase()) != -1 || widget.data[cont]['nombre'].indexOf(textoBusqueda.toLowerCase()) != -1  )
                                  pdfs(
                                    context,
                                    "${widget.data[cont]['nombre']}",
                                    "${widget.data[cont]['url']}",
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


  String urlPDFPath = "";
  String myString;
  Widget pdfs(BuildContext context, String nombrePdf, String url){
    
    return Container(
      child: Dismissible(
      // movementDuration: Duration(milliseconds: 5}000),
      onDismissed: (direction){
        print(direction);
        print(urlGlobalPdf+"/"+url);
        if(direction == DismissDirection.startToEnd){
          carga.cargando(context, "CARGANDO PDF");
          getFileFromUrl("http://192.168.1.7/otro.pdf").then((f) {
              urlPDFPath = f.path;
              print(urlPDFPath);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                    VerPdf(
                      path: f.path
                    )
                )
              );
          });
        }else{

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
                FontAwesomeIcons.eye,
                color: AppTheme.white,
              ),
            )
          ],
        ),
      ),
      secondaryBackground: Container(
        color: AppTheme.secondary,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.rtl,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                FontAwesomeIcons.download,
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
                      image: AssetImage('assets/img/pdf.png')
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
                        '$nombrePdf',
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
      )
    )
    );
  }
  
  Future<File> getFileFromUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      print("Error opening url file");
      // throw Exception("");
    }
  }
}