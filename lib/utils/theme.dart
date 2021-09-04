import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData of(context) {
    var theme = Theme.of(context);
    return theme.copyWith(
        primaryColor: AppColors.black,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primaryColorLight: AppColors.lightGrey,
        accentColor: AppColors.greyAccent,
        bottomAppBarColor: AppColors.lightGrey,
        backgroundColor: AppColors.white,
        dialogBackgroundColor: AppColors.white,
        errorColor: AppColors.greyAccent,
        dividerColor: Colors.transparent);
  }
}

class AppColors {
  static const greyDark = Color.fromRGBO(241, 241, 242, 1);
  static const primaryColor = Color(0xFFff7652);
  static const toolBarTitleColor = Color(0xFF232323);
  static const toolBarIconColor = Color.fromRGBO(242, 137, 71, 1);
  static const blackDot = Color.fromRGBO(112, 112, 112, 1);
  static const verificationColor = Color.fromRGBO(139, 149, 154, 1);
  static const chatGrey = Color.fromRGBO(185, 185, 185, 1);
  static const chatBottomBack = Color.fromRGBO(244, 244, 244, 0.94);
  static const searchTextColor = Color.fromRGBO(151, 151, 151, 1);
  static const circleAvatarBack = Color.fromRGBO(245, 242, 242, 1);
  static const textBlueColor = Color.fromRGBO(140, 181, 255, 1);
  static const darkBlueColor = Color.fromRGBO(60, 130, 255, 1);
  static const tickBlue = Color.fromRGBO(56, 186, 255, 1);
  static const textGreyColor = Color.fromRGBO(188, 188, 188, 1);
  static const textGreyBold = Color.fromRGBO(105, 105, 105, 1);
  static const boxGreyColor = Color.fromRGBO(206, 206, 206, 1);
  static const textTabColr = Color.fromRGBO(181, 184, 187, 1);
  static const snackBarBackErrorColor = Color(0xFFDB3022);
  static const black = Color(0xFF222222);
  static const snakBarBackColor = Color(0xFF222222);
  static const lightGrey = Color.fromRGBO(226, 230, 234, 1);
  static const rating = Color.fromRGBO(232, 205, 115, 1);
  static const emptyRating = Color.fromRGBO(246, 235, 199, 1);
  static const greenText = Color.fromRGBO(61, 169, 71, 1);
  static const greyAccent = Color.fromRGBO(126, 150, 159, 1);
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const lightGreyColor = Color.fromRGBO(230, 229, 229, 1);
  static const greylight = const Color(0xffF5F5F5);
}

class FontFamily {
  static const String SFPro = "SFProDisplay-Regular.ttf";
  static const String Roboto = "Roboto-Regular.ttf";
}
