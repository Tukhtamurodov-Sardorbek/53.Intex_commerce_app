import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData light = ThemeData(
    highlightColor: AppColors.transparent,
    splashColor: AppColors.transparent,
    hoverColor: AppColors.transparent,



    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
