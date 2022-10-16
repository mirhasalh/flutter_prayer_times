import 'package:flutter/material.dart';
import 'package:prayer_times/src/assets/font_assets.dart';
import 'package:prayer_times/src/palette.dart';

class AppTheme {
  ThemeData themeData = ThemeData(
    // This is the theme of your application.
    //
    // Try running your application with "flutter run". You'll see the
    // application has a blue toolbar. Then, without quitting the app, try
    // changing the primarySwatch below to Colors.green and then invoke
    // "hot reload" (press "r" in the console where you ran "flutter run",
    // or simply save your changes to "hot reload" in a Flutter IDE).
    // Notice that the counter didn't reset back to zero; the application
    // is not restarted.
    primarySwatch: Colors.teal,
    fontFamily: FontAssets.euclid,
    primaryTextTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Palette.eerieBlack,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
    }),
    dividerColor: Palette.cadetBlueCrayole,
    dividerTheme: const DividerThemeData(
      color: Palette.cadetBlueCrayole,
      thickness: 0.5,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Palette.darkGray),
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        color: Palette.eerieBlack,
        fontFamily: FontAssets.euclid,
        fontWeight: FontWeight.normal,
      ),
    ),
    scaffoldBackgroundColor: Palette.cultured,
  );
}
