import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intex_commerce/core/app_services/environment_service.dart';

class BaseOption extends ChangeNotifier {

  static BaseOptions baseDioOptions() {
    return BaseOptions(baseUrl: Environment.baseURL);
  }
}
