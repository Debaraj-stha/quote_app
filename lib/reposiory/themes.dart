import 'package:flutter/material.dart';
import 'package:quote/resources/appColor.dart';

class Themes {
  final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(31, 88, 130, 144),
    expansionTileTheme: const ExpansionTileThemeData(
      textColor: Colors.white,
      collapsedTextColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    dividerTheme: const DividerThemeData(color: Colors.white),
    primaryColor: Colors.grey,
    primaryTextTheme: const TextTheme(
        titleLarge:
            TextStyle(color: Colors.white, fontFamily: "Roboto", fontSize: 30),
        titleMedium:
            TextStyle(color: Colors.white, fontFamily: "Roboto", fontSize: 25),
        titleSmall:
            TextStyle(color: Colors.white, fontFamily: "Roboto", fontSize: 15),
        bodyLarge: TextStyle(),
        bodySmall:
            TextStyle(color: Colors.white, fontFamily: "Roboto", fontSize: 16)),
    textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.white)),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black38,
      elevation: 1,
      selectedItemColor: Colors.white,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(color: Colors.white),
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.darkAppBarColor),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );

  final lightTheme = ThemeData(
    // scaffoldBackgroundColor: const Color.fromARGB(31, 88, 130, 144),
    expansionTileTheme: const ExpansionTileThemeData(
      textColor: Colors.white,
      collapsedTextColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    dividerTheme: const DividerThemeData(color: Colors.black),
    primaryColor: Colors.grey,
    primaryTextTheme: const TextTheme(
        titleLarge:
            TextStyle(color: Colors.black, fontFamily: "Roboto", fontSize: 30),
        titleMedium:
            TextStyle(color: Colors.black, fontFamily: "Roboto", fontSize: 25),
        titleSmall:
            TextStyle(color: Colors.black, fontFamily: "Roboto", fontSize: 15),
        bodyLarge: TextStyle(),
        bodySmall:
            TextStyle(color: Colors.black, fontFamily: "Roboto", fontSize: 16)),
    textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.white)),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 1,
      selectedItemColor: Colors.black,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(color: Colors.black),
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.darkAppBarColor),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );
}
