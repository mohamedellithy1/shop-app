import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';


ThemeData LightTheme=ThemeData(
    textTheme: TextTheme(

      bodyText1: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        color: Colors.black,


      ),

    ),
 fontFamily: 'Jannah',
    primarySwatch:Colors.teal,
    appBarTheme: AppBarTheme(

      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light ,
        statusBarColor: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,

    ),
    //------------------------------------------
    scaffoldBackgroundColor: Colors.white,
    //------------------------------------------
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,

    )

);
ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor: HexColor('333739'),
    primarySwatch: Colors.teal,
    appBarTheme: AppBarTheme(
        backgroundColor: HexColor('333739'),
        backwardsCompatibility: false,
        systemOverlayStyle:SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        )
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
          color: Colors.white,
        )
    ),
    fontFamily: 'Jannah',
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor:Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor:HexColor('333739'),
    )

);
