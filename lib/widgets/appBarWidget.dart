import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infogestion/extras/appTheme.dart';

class AppBarWidget extends StatelessWidget {
  
  final String titulo; 
  final Function press;
  final Icon icono;

  AppBarWidget({
    Key key ,
    this.titulo,
    this.press,
    this.icono
    }) : super(key: key );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primary,
      child: SizedBox(
        // height: AppBarWidget().preferredSize.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 8, left: 8),
              child: Container(
                // width: AppBarWidget().preferredSize.height - 8,
                // height: AppBarWidget().preferredSize.height - 8,
              ),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "$titulo",
                    style: new TextStyle(
                      fontSize: 22,
                      color: AppTheme.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: icono,
                color: AppTheme.white,
                onPressed: press
              ),
            )
            
          ],
        ),
      )
    );
  }
}