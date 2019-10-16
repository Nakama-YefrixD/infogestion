
import 'package:flutter/material.dart';
import 'package:infogestion/extras/appTheme.dart';

class carga{
  static void cargando(BuildContext context, String texto) {
    funcionCargando(context, texto);
  }
  static Future<void> funcionCargando(BuildContext context, String texto) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(texto,
            style: TextStyle(
              fontSize: 20,
              color: AppTheme.darkText,
              fontWeight: FontWeight.w700,
              ),
            textAlign: TextAlign.center,
            ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 50.0,
                  child: Center(
                    child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.secondary),
                          ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CargandoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Center(
        child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
      ),
    );
  }
}