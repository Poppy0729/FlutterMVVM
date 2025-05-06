import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const String fontName = "Quicksand";
  // *****************
  // static colors
  // *****************
  static const Color primaryColor = Color(0xff5a5a5a);
  static const Color primaryVariantColor = Colors.white;
  static const Color onPrimaryColor = Color(0xffbdbdbd);
  static const Color textColorPrimary = Colors.white;
  static const Color textColorSecond = Colors.black;
  static const Color textButtonColor = Color(0xff433938);
  static const Color textButtonDisabledColor = Color(0xff7B7B7B);
  static const Color _appBarColorLight = Color(0xff5a5a5a); //Color(0xff6F5F5E);
  static const Color _iconColor = Colors.white;
  static const Color _accentColor = Colors.black;
  static const Color yellowColor = Color(0xffFFD400);
  static const Color baseBackgroundColor = Color(0xff5a5a5a);
  static const Color greyStrokeColor = Color(0xffB5B5B5);
  static const Color shadowColor = Color(0xff393939);
  static const Color disabledColor = Color(0xff5A5A5A);
  static const Color secondaryButtonColor = Color(0xffE2DFDF);
  static const Color disabledBorderColor = Color(0xff484848);
  static const Color reloadMessageColor = Color(0xffFACCCC);
  static const Color snackBarOrange = Color(0xffFCA703);
  static const Color loadingColor = Color(0xffC4C4C4);
  static const Color black121212 = Color(0xff121212);
  static const Color blue9FD4FD = Color(0xff9FD4FD);
  static const Color black161313 = Color(0xff161313);
  static const Color bg363636 = Color(0xff363636);
  static const Color maroonGray = Color(0xff594C4B);

  static const Color boxLightColor = Color(0xffE2DFDF);
  static const Color greenColor = Color(0xff1AAA55);
  static const Color blueColor = Color(0xff0D76C9);
  static const Color brownColor = Color(0xff6F5F5E);
  static const Color errorColor = Color(0xffE60000);


  // *****************
  // Text Style - light
  // *****************
  static const TextStyle titleSmall = TextStyle(
      color: Colors.white,
      fontFamily: fontName,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static const TextStyle _lightBodyMedium = TextStyle(
      color: textColorPrimary,
      fontFamily: fontName,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 16);

  static const TextStyle _lightBodyLarge = TextStyle(
      color: textColorPrimary,
      fontFamily: fontName,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 18);

  static const TextStyle bodySmall = TextStyle(
      color: textColorPrimary,
      fontFamily: fontName,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 12);

  static const TextStyle titleMedium = TextStyle(
    color: textColorPrimary,
    fontFamily: fontName,
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle body1 = TextStyle(
    color: textColorSecond,
    fontFamily: fontName,
    fontSize: 16,
  );

  static const TextTheme _lightTextTheme = TextTheme(
    bodySmall: bodySmall,
    bodyLarge: _lightBodyLarge,
    bodyMedium: _lightBodyMedium,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
  );

  static const AppBarTheme appBarTheme = AppBarTheme(
      titleSpacing: 0,
      elevation: 0,
      color: Colors.transparent,
      iconTheme: IconThemeData(color: _iconColor),
      titleTextStyle: titleSmall);

  static final ElevatedButtonThemeData elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return disabledColor;
        }
        return yellowColor;
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return textButtonDisabledColor;
        }
        return textButtonColor;
      }),
      elevation: const MaterialStatePropertyAll(0),
      side: MaterialStateBorderSide.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return const BorderSide(color: disabledBorderColor);
        }
        return const BorderSide(color: Colors.transparent);
      }),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      )),
      minimumSize: const MaterialStatePropertyAll(Size(220, 60)),
    ),
  );

  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: _lightBodyMedium.copyWith(
        color: Colors.black,
      ),
      hintStyle: _lightBodyMedium.copyWith(
        color: const Color(0xffBDBDBD),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: greyStrokeColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: greyStrokeColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16));

  // *****************
  // Theme
  // *****************

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: fontName,
    scaffoldBackgroundColor: baseBackgroundColor,
    appBarTheme: appBarTheme,
    colorScheme: const ColorScheme.light(
        primary: primaryColor,
        background: baseBackgroundColor,
        onPrimary: onPrimaryColor,
        secondary: _accentColor,
        primaryContainer: primaryVariantColor,
        error: errorColor),
    primaryColor: _appBarColorLight,
    textTheme: _lightTextTheme,
    bottomAppBarTheme: const BottomAppBarTheme(
        padding: EdgeInsets.all(0), color: Colors.transparent),
    highlightColor: yellowColor,
    shadowColor: shadowColor,
    elevatedButtonTheme: elevatedButtonTheme,
    inputDecorationTheme: inputDecorationTheme,
    canvasColor: Colors.cyanAccent,
    dropdownMenuTheme: const DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
      ),
    ),
    menuTheme: const MenuThemeData(
      style: MenuStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
        padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
      ),
    ),
  );
}