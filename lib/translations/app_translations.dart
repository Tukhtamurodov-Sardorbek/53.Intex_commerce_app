import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intex_commerce/core/app_services/database_service.dart';
import 'ru.dart';
import 'uz.dart';


class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ru': ru,
    'uz': uz,
  };

  static Locale defaultLanguage(BuildContext context) {
    late String? locale;
    if(DatabaseService.checkDatabase(DatabaseKeys.language)) {
      locale = DatabaseService.loadString(DatabaseKeys.language);
    }else{
      locale = null;
    }

   if (locale != null && locale == 'uz') {
      return const Locale('uz');
    } else {
      return const Locale('ru');
    }
  }
}