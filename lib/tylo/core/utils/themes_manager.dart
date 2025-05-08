import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';


ThemeData darkTheme(){
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorManager.backgroundColor,
    appBarTheme:  AppBarTheme(
      backgroundColor: ColorManager.backgroundColor.withOpacity(0.9),
    ),
    textTheme: const TextTheme(
      bodySmall:  TextStyle(
        color: ColorManager.white,
        fontSize: FontManager.s12,
        fontFamily: 'ReadexPro',
      ),
      bodyMedium:  TextStyle(
        color: ColorManager.white,
        fontSize: FontManager.s14,
        fontFamily: 'ReadexPro',
      ),
      bodyLarge: TextStyle(
        color: ColorManager.white,
        fontSize: FontManager.s16,
        fontFamily: 'ReadexPro',
      ),
      displayLarge: TextStyle(
        color: ColorManager.white,
        fontSize: FontManager.s18,
        fontFamily: 'ReadexPro',
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: ColorManager.white,
      contentTextStyle: TextStyle(
        color: ColorManager.black,
        fontSize: FontManager.s30,
        fontFamily: 'ReadexPro',
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorManager.primaryColor,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(ColorManager.primaryColor),
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: ColorManager.backgroundColor,
      dividerColor: ColorManager.grey.withOpacity(0.3),
      indicatorColor: ColorManager.primaryColor,
      unselectedLabelColor: ColorManager.backgroundColor.withOpacity(0.3),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.primaryColor.withOpacity(0.5),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorManager.backgroundColor.withOpacity(0.9),
      selectedItemColor: ColorManager.white,
      unselectedItemColor: ColorManager.grey.withOpacity(0.3),
      unselectedLabelStyle: const TextStyle(
        color: ColorManager.grey,
        fontSize: FontManager.s10,
        fontFamily: 'ReadexPro',
      ),
      selectedLabelStyle: const TextStyle(
        color: ColorManager.black,
        fontSize: FontManager.s10,
        fontFamily: 'ReadexPro',
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorManager.backgroundColor,
    ),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: ColorManager.messageTextFieldBGColor
    ),

  ) ;
}