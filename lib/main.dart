import 'package:flutter/material.dart';
import 'package:infogestion/login.dart';
import 'package:infogestion/widgets/logo.dart';


void main() => runApp(
  MaterialApp(
    home: MainApp(),
    theme: ThemeData(
      primaryColor: Color(0xFF1F3C88
    ),
  ))
);


class MainApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MainAppState();

}

class _MainAppState extends State<MainApp>{
  Widget _rootPage = LoginPage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => _rootPage
          ),);
      },
    );

    getRootPage().then((Widget page) async{
      
    });
  }
  
  
  Future<Widget> getRootPage() async =>
    1 == null 
     ?LoginPage()
     :LoginPage();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/img/cargando.jpg"),
        //     fit: BoxFit.cover
        //   ),
        // ),

        child: Center(
          child: LogoImg(),
        )
      ),
    );

    
  }
}