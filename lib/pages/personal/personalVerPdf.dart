import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:infogestion/pages/admin/adminPage.dart';
import 'package:infogestion/pages/personal/listaPdfs.dart';

class PersonalVerPdf extends StatefulWidget {
  final String path;
  final String nombrePdf;

  const PersonalVerPdf({Key key, this.path, this.nombrePdf}) : super(key: key);
  @override
  _PersonalVerPdfState createState() => _PersonalVerPdfState();
}

class _PersonalVerPdfState extends State<PersonalVerPdf> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        
      },
      child: Scaffold(
        
        body: Stack(
          children: <Widget>[
            PDFView(
              filePath: widget.path,
              autoSpacing: true,
              enableSwipe: true,
              pageSnap: true,
              swipeHorizontal: true,
              nightMode: false,
              onError: (e) {
                print(e);
              },
              onRender: (_pages) {
                setState(() {
                  _totalPages = _pages;
                  pdfReady = true;
                });
              },
              onViewCreated: (PDFViewController vc) {
                _pdfViewController = vc;
              },
              onPageChanged: (int page, int total) {
                setState(() {});
              },
              onPageError: (page, e) {},
            ),
            !pdfReady
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Offstage()
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (BuildContext context ) => ListaPdf(
                  
                )
              )
            );
          },
          label: Text('SALIR'),
          icon: Icon(Icons.error_outline),
          backgroundColor: Colors.redAccent,
        ),
      )
    );
  }
}
