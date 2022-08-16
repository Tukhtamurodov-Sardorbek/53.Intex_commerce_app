import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{

  static String get baseURL{
    if(kReleaseMode) {
      return dotenv.get('serverProduction');
    }else{
      return dotenv.get('serverDevelopment');
    }
  }

  static String envVariable(String key){
    return dotenv.get(key);
  }
}