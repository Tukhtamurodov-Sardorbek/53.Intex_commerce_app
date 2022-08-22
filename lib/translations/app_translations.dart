import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intex_commerce/core/app_services/database_service.dart';
import 'ru.dart';
import 'uz.dart';
import 'package:get_storage/get_storage.dart';


// class AppTranslations extends Translations {
//   @override
//   Map<String, Map<String, String>> get keys => {
//     'ru': ru,
//     'uz': uz,
//   };
// }

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'uz_UZ': uz,
    'ru_RU': ru,
  };

  static const fallbackLocale = Locale('ru', 'RU');

  static final langs = [
    'uz',
    'ru',
  ];

  static final List<Locale> locales = [
    const Locale('uz', 'UZ'),
    const Locale('ru', 'RU'),
  ];

  // static final locale = defLanguage(
  //   StorageService().getData<String>(StorageKeys.language) ?? AppTranslations.langs[1],
  // );

  static Locale defaultLanguage(BuildContext context) {
    late String? locale;
    if(StorageService.to.checkData(StorageKeys.language)){
      locale = StorageService.to.getData(StorageKeys.language);
    }else{
      locale = null;
    }

    if(locale == null){
      return locales[1];
    }
    else if (locale == 'uz') {
      return locales[0];
    } else if(locale == 'ru') {
      return locales[1];
    } else {
      return locales[1];
    }
  }

  static Locale defLanguage(String code) {
    var index = langs.indexOf(code);
    return locales[index];
  }

  static changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    if (locale != null) {
      Get.updateLocale(locale);
      StorageService().setData<String>(StorageKeys.language, lang);
    }
  }

  static Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.deviceLocale;
  }
}