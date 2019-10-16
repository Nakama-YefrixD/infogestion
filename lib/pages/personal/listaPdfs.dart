import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infogestion/extras/appTheme.dart';
import 'package:infogestion/extras/globals.dart';
import 'package:infogestion/login.dart';
import 'package:infogestion/pages/personal/personalVerPdf.dart';
import 'package:infogestion/widgets/appBarWidget.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:infogestion/widgets/cargando.dart';

class ListaPdf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

    return new MaterialApp(
      title: 'PDF',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ListaPdfsPersonal(
        title: 'DESCARGAR PDFS',
        platform: platform,
      ),
    );
  }
}

class ListaPdfsPersonal extends StatefulWidget {
  final TargetPlatform platform;

  ListaPdfsPersonal({Key key, this.title, this.platform}) : super(key: key);

  final String title;

  @override
  _ListaPdfsPersonalState createState() => new _ListaPdfsPersonalState();
}

class _ListaPdfsPersonalState extends State<ListaPdfsPersonal> with WidgetsBindingObserver {
  final _documents = [
    {
      'name': 'Learning Android Studio',
      'link':
          'http://barbra-coco.dyndns.org/student/learning_android_studio.pdf'
    },
    {
      'name': 'Android Programming Cookbook',
      'link':
          'http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf'
    },
    {
      'name': 'iOS Programming Guide',
      'link':
          'http://darwinlogic.com/uploads/education/iOS_Programming_Guide.pdf'
    },
    {
      'name': 'Objective-C Programming (Pre-Course Workbook',
      'link':
          'https://www.bignerdranch.com/documents/objective-c-prereading-assignment.pdf'
    },
  ];

  final _images = [
    {
      'name': 'Arches National Park',
      'link':
          'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg'
    },
    {
      'name': 'Canyonlands National Park',
      'link':
          'https://upload.wikimedia.org/wikipedia/commons/7/78/Canyonlands_National_Park%E2%80%A6Needles_area_%286294480744%29.jpg'
    },
    {
      'name': 'Death Valley National Park',
      'link':
          'https://upload.wikimedia.org/wikipedia/commons/b/b2/Sand_Dunes_in_Death_Valley_National_Park.jpg'
    },
    {
      'name': 'Gates of the Arctic National Park and Preserve',
      'link':
          'https://upload.wikimedia.org/wikipedia/commons/e/e4/GatesofArctic.jpg'
    }
  ];

  final _videos = [
    {
      'name': 'Big Buck Bunny',
      'link':
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
    },
    {
      'name': 'Elephant Dream',
      'link':
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
    }
  ];

  List<_TaskInfo> _tasks;
  List<_ItemHolder> _items;
  bool _isLoading;
  bool _permissisonReady;
  String _localPath;



  @override
  void initState() {
    super.initState();
    _getPdfs();
    FlutterDownloader.registerCallback((id, status, progress) {
      print(
          'Descargar task ($id) es un estado ($status) y proceso ($progress)');
      final task = _tasks.firstWhere((task) => task.taskId == id);
        
      setState(() {
        
        task?.status = status;
        task?.progress = progress;
      });
    });

    _isLoading = true;
    _permissisonReady = false;

    _prepare();
  }

  @override
  void dispose() {
    FlutterDownloader.registerCallback(null);
    super.dispose();
  }


  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 0));
    return true;
  }
  
  String textoBusqueda = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox();
          } else {
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
                      titulo: "Lista de PDFS",
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
                            return _isLoading
                              ? new Center(
                                  child: new CircularProgressIndicator(),
                                )
                              : _permissisonReady
                                ? new Stack(
                                  children: <Widget>[
                                    ListView(
                                      children: <Widget>[
                                        if(buscar)
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
                                        
                                        for(int cont = 0; cont < cantDataPdf; cont++)
                                        if(dataPdf[cont]['nombrePdf'].indexOf(textoBusqueda.toUpperCase()) != -1 || dataPdf[cont]['nombrePdf'].indexOf(textoBusqueda.toLowerCase()) != -1  )
                                        pdfs(
                                          cont,
                                          "${dataPdf[cont]['nombrePdf']}",
                                          "${dataPdf[cont]['urlPdf']}",
                                          dataPdf[cont]['estadoPdf'],
                                          dataPdf[cont]['procesoDescarga'],
                                        ),
                                      ],
                                    ),
                                  ]
                                )
                          : new Container(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 24.0),
                                      child: Text(
                                        'Please grant accessing storage permission to continue -_-',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.blueGrey, fontSize: 18.0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32.0,
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        _checkPermission().then((hasGranted) {
                                          setState(() {
                                            _permissisonReady = hasGranted;
                                          });
                                        });
                                      },
                                      child: Text(
                                        'Retry',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      )
                                    )
                                  ],
                                ),
                              ),
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
        }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          child: 
              buscar == false
              ?IconButton(
                icon: Icon(
                  FontAwesomeIcons.search, 
                  color: AppTheme.white,
                  ), 
                onPressed: () {
                  setState(() {
                    buscar = true;
                  });
                },
                tooltip: "Buscar un usuario",
              )
            :IconButton(
                icon: Icon(
                  FontAwesomeIcons.timesCircle, 
                  color: AppTheme.white,
                  ), 
                onPressed: () {
                  setState(() {
                    buscar = false;
                  });
                },
                tooltip: "Buscar un usuario",
              ),
          backgroundColor: Colors.orangeAccent,
          tooltip: "Buscar documento",
        ),
    );
  }
  bool buscar = false;
  String urlPDFPath = "";
  Widget pdfs(int posicion, String nombrePdf, String url, int estadoPdf, int proceso){
    

    return Container(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: <Widget>[
          IconSlideAction(
            color: Colors.green,
            icon: FontAwesomeIcons.eye,
            onTap: (){
              carga.cargando(context, "Cargando PDF.");
              Navigator.of(context).pop();
              getFileFromUrl("http://www.elsoca.org/pdf/libreria/programa_de_transicion.pdf").then((f) {
                  urlPDFPath = f.path;
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                        PersonalVerPdf(
                          path: f.path,
                          nombrePdf: nombrePdf,
                        )
                    )
                  );
                  // Navigator.of(context).pop();
              });
            },
          ),
          // if(estadoPdf == 1)
            IconSlideAction(
              color: AppTheme.secondary,
              icon: FontAwesomeIcons.download,
              foregroundColor: Colors.white,
              onTap: (){
                print('estadopf');
                setState(() {
                  dataPdf[posicion]['estadoPdf'] = 2;  
                });
                _requestDownload("http://www.elsoca.org/pdf/libreria/programa_de_transicion.pdf", posicion);
              },
            ),

          // if(estadoPdf == 2)
          //   IconSlideAction(
          //     color: Colors.red,
          //     icon: FontAwesomeIcons.pause,
          //     foregroundColor: Colors.white,
          //     onTap: (){
                
          //       setState(() {
          //         dataPdf[posicion]['estadoPdf'] = 3;  
          //       });
          //       _pauseDownload(posicion);
          //     },
          //   ),

            // if(estadoPdf == 3)
            // IconSlideAction(
            //   color: AppTheme.primary,
            //   icon: FontAwesomeIcons.play,
            //   foregroundColor: Colors.white,
            //   onTap: (){
                
            //     setState(() {
            //       dataPdf[posicion]['estadoPdf'] = 2;  
            //     });
            //     _resumeDownload(posicion);
            //   },
            // ),
          
          
        ],
        child: Container(
          color: AppTheme.white,
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Column(
              children: <Widget>[
                Row(
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
                    // Expanded(
                    //   child: new Padding(
                    //     padding:
                    //         const EdgeInsets.only(
                    //             left: 8.0),
                    //     child: _buildActionForTask(1),
                    //   ),
                    // )
                  ],
                ),
                // if(estadoPdf == 2)
                // new LinearProgressIndicator(
                //   value: proceso /100,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var dataPdf;
  int cantDataPdf = 0;
  _getPdfs() async{
    String url =
          "$urlPersonal/mostrarPdfs";
    print(url);
    var response = await http.post(url, body: {
                        "api_token" : "$globaltoken",
                        "idUsuario" : "$globalId",
                      });

      
    print(response.body);
    if (response.statusCode == 200) {

      final map          = json.decode(response.body);
      final result       = map["result"];
      final code         = map["code"];
      
      if(code == true){
        setState(() {
          this.dataPdf = result;
          this.cantDataPdf = this.dataPdf.length;
          
        });
      }
      
    }else{
      
    }

  }

  Widget _buildActionForTask(int estado) {
    if (estado == 1) {
      return new RawMaterialButton(
        onPressed: () {
          // _requestDownload(task);
        },
        child: new Icon(Icons.file_download),
        shape: new CircleBorder(),
        constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (estado == 2) {
      return new RawMaterialButton(
        onPressed: () {
          // _pauseDownload(task);
        },
        child: new Icon(
          Icons.pause,
          color: Colors.red,
        ),
        shape: new CircleBorder(),
        constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (estado == 3) {
      return new RawMaterialButton(
        onPressed: () {
          // _resumeDownload(task);
        },
        child: new Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
        shape: new CircleBorder(),
        constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (estado == 4) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Text(
            'Ready',
            style: new TextStyle(color: Colors.green),
          ),
          RawMaterialButton(
            onPressed: () {
              // _delete(task);
            },
            child: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            shape: new CircleBorder(),
            constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (estado == 5) {
      return new Text('Canceled', style: new TextStyle(color: Colors.red));
    } else if (estado == 6) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Text('Failed', style: new TextStyle(color: Colors.red)),
          RawMaterialButton(
            onPressed: () {
              // _retryDownload(task);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.green,
            ),
            shape: new CircleBorder(),
            constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else {
      return null;
    }
  }

  void _requestDownload(String url, int posicion) async {
    
    dataPdf[posicion]['idDescargaPdf'] = 
      await FlutterDownloader.enqueue(
        url: "http://www.bodyandbalance.ca/images/new/twitter_t.png",
        headers: {
          "auth": "test_for_sql_encoding"
        },
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true);
  }

  void _cancelDownload(_TaskInfo task) async {
    await FlutterDownloader.cancel(taskId: task.taskId);
  }

  void _pauseDownload(int posicion) async {
    
    await FlutterDownloader.pause(taskId: dataPdf[posicion]['idDescargaPdf']);
  }

  void _resumeDownload(int posicion) async {
    String newTaskId = await FlutterDownloader.resume(taskId: dataPdf[posicion]['idDescargaPdf']);
    dataPdf[posicion]['idDescargaPdf'] = newTaskId;
  }

  void _retryDownload(_TaskInfo task) async {
    String newTaskId = await FlutterDownloader.retry(taskId: task.taskId);
    task.taskId = newTaskId;
  }

  Future<bool> _openDownloadedFile(_TaskInfo task) {
    return FlutterDownloader.open(taskId: task.taskId);
  }

  void _delete(_TaskInfo task) async {
    await FlutterDownloader.remove(taskId: task.taskId, shouldDeleteContent: true);
    await _prepare();
    setState(() {});
  }

  Future<bool> _checkPermission() async {
    if (widget.platform == TargetPlatform.android) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.storage]);
        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<Null> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    int count = 0;
    _tasks = [];
    _items = [];

    _tasks.addAll(_documents.map((document) =>
        _TaskInfo(name: document['name'], link: document['link'])));

    _items.add(_ItemHolder(name: 'Documents'));
    for (int i = count; i < _tasks.length; i++) {
      _items.add(_ItemHolder(name: _tasks[i].name, task: _tasks[i]));
      count++;
    }

    _tasks.addAll(_images
        .map((image) => _TaskInfo(name: image['name'], link: image['link'])));

    _items.add(_ItemHolder(name: 'Images'));
    for (int i = count; i < _tasks.length; i++) {
      _items.add(_ItemHolder(name: _tasks[i].name, task: _tasks[i]));
      count++;
    }

    _tasks.addAll(_videos
        .map((video) => _TaskInfo(name: video['name'], link: video['link'])));

    _items.add(_ItemHolder(name: 'Videos'));
    for (int i = count; i < _tasks.length; i++) {
      _items.add(_ItemHolder(name: _tasks[i].name, task: _tasks[i]));
      count++;
    }

    tasks?.forEach((task) {
      for (_TaskInfo info in _tasks) {
        if (info.link == task.url) {
          info.taskId = task.taskId;
          info.status = task.status;
          info.progress = task.progress;
        }
       
      }
    });

    _permissisonReady = await _checkPermission();

    _localPath = (await _findLocalPath()) + '/Download';

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<String> _findLocalPath() async {
    final directory = widget.platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
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

class _TaskInfo {
  final String name;
  final String link;

  String taskId;
  int progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  _TaskInfo({this.name, this.link});
}

class _ItemHolder {
  final String name;
  final _TaskInfo task;

  _ItemHolder({this.name, this.task});
}
