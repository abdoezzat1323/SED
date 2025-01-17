import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sed/presentation/resources/fonts_manager.dart';
import 'package:sed/presentation/resources/styles_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main colors
    primaryColorLight: ColorsManager.primaryColor,
    primaryColorDark: ColorsManager.primaryColor,
    disabledColor: ColorsManager.grey1,
    splashColor: ColorsManager.primaryColor,

    //cardView  Theme
    cardTheme: CardTheme(
        color: ColorsManager.primaryText,
        shadowColor: ColorsManager.grey,
        elevation: AppSize.s4),

    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsManager.primaryBackground,
      iconTheme: IconThemeData(color: ColorsManager.secondaryText),
      elevation: AppSize.s4,
      shadowColor: ColorsManager.primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorsManager.background,
          statusBarBrightness: Brightness.light),
      titleTextStyle: getRegularStyle(
          fontSize: FontSize.s22, color: ColorsManager.secondaryText),
    ),

    //button Theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorsManager.grey1,
      buttonColor: ColorsManager.primaryColor,
      splashColor: ColorsManager.primaryColor,
    ),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(
              fontSize: FontSize.s17, color: ColorsManager.primaryText),
          backgroundColor: ColorsManager.primaryColor,
          disabledBackgroundColor: ColorsManager.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s24),
          )),
    ),

    //text theme
    textTheme: TextTheme(
        displayLarge: getLightStyle(
            color: ColorsManager.primaryText, fontSize: FontSize.s24),
        headlineLarge: getSemiBoldStyle(
            color: ColorsManager.primaryText, fontSize: FontSize.s16),
        headlineMedium: getRegularStyle(
            color: ColorsManager.primaryText, fontSize: FontSize.s14),
        titleMedium: getMediumStyle(
            color: ColorsManager.secondaryText, fontSize: FontSize.s14),
        bodyLarge: getRegularStyle(color: ColorsManager.grey1),
        bodySmall: getRegularStyle(color: ColorsManager.secondaryText)),

    //input decoration Theme (Text form field)
    inputDecorationTheme: InputDecorationTheme(
      //content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      filled: true,
      fillColor: ColorsManager.secondaryBackground,
      //hint style
      hintStyle: getRegularStyle(
          color: ColorsManager.secondaryText, fontSize: FontSize.s14),
      labelStyle: getMediumStyle(
          color: ColorsManager.secondaryText, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorsManager.error),

      //enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),

      //focused border style
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),

      //error border style
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),

      //focused border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    colorScheme: ColorScheme(
        background: ColorsManager.primaryColor,
        brightness: Brightness.light,
        error: ColorsManager.error,
        onBackground: ColorsManager.primaryText,
        onError: ColorsManager.primaryText,
        onPrimary: ColorsManager.primaryText,
        onSecondary: ColorsManager.secondaryText,
        onSurface: ColorsManager.secondaryText,
        primary: ColorsManager.primaryColor,
        surface: ColorsManager.secondaryBackground,
        secondary: ColorsManager.secondaryColor),
  );
}

class ThemeManager {
  static bool isDarkMode = true;
}
