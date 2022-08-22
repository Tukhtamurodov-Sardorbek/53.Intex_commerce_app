import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intex_commerce/core/app_services/environment_service.dart';
import 'package:intex_commerce/data/exceptions.dart';
import '../core/app_services/log_service.dart';

class DioService {
  /// Header
  static Map<String, String> getHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };
    return headers;
  }

  /// Options
  static var options = BaseOptions(
    baseUrl: Environment.baseURL,
    headers: getHeaders(),
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  /// Dio
  static final Dio dio = Dio(options);

  /// Requests
  Future<String?> GET({required String api, required Map<String, dynamic> params}) async {
    try {
      Response response = await dio.get(api, queryParameters: params);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonEncode(response.data);
      }
    } on DioError catch (e) {}
    return null;
  }

  Future<String?> getFile({required String api}) async {
    Response response = await Dio().get(api, onReceiveProgress: showDownloadProgress);
    if (response.statusCode == 200) return jsonEncode(response.data);
    return null;
  }

  Future<String?> POST({required String api, required Map<String, dynamic> body}) async {
    try {
      Response response = await dio.post(api, data: body);
      Log.i('STATUS => ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonEncode(response.data);
      }
    } on DioError catch (e) {
      Log.wtf('STAUS: ${e.response?.statusCode}');
      if(e.response?.statusCode == 406){
        return '406';
      }
    }
    return null;
  }

  // Future<String?> POST({required String api, required Map<String, dynamic> params}) async {
  //   try {
  //     Response response = await dio.post(api, data: params);
  //     Log.i('STATUS => ${response.statusCode}');
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return jsonEncode(response.data);
  //     }
  //     else if(api == Environment.envVariable('apiCreateOrder') && response.statusCode == 406){
  //       return 'not_available';
  //     }
  //     return null;
  //   } on DioError catch (e) {
  //     return e.response!.statusCode == 406 ? 'not_available' : jsonEncode(e.response!.data);
  //   }
  // }

  Future<String?> postFile({required String api, required File file}) async {
    FormData formData = FormData.fromMap(
      {
        "file": MultipartFile.fromFileSync(
          file.path,
          filename: DateTime.now().toIso8601String(),
        ),
      },
    );
    try {
      Response response = await Dio().post(api, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonEncode(response.data);
      }
    } on DioError catch (e) {}
    return null;
  }

  Future<String?> PUT({required String api, required Map<String, dynamic> body}) async {
    try {
      Response response = await dio.put(api, data: jsonEncode(body));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonEncode(response.data);
      }
      return null;
    } on DioError catch (e) {}
    return null;
  }

  Future<String?> PATCH({required String api, required Map<String, dynamic> params}) async {
    Response response = await dio.patch(api, queryParameters: params);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonEncode(response.data);
    }
    return null;
  }

  Future<String?> DELETE({required String api, Map<String, dynamic>? params}) async {
    try {
      if (params != null) {
        Response response = await dio.delete(api, data: params);
        if (response.statusCode == 200 || response.statusCode == 201) {
          return jsonEncode(response.data);
        }
      } else {
        Response response =
            await Dio().delete(api, queryParameters: paramsEmpty());
        if (response.statusCode == 200 || response.statusCode == 201) {
          return jsonEncode(response.data);
        }
      }

      return null;
    } on DioError catch (e) {}
    return null;
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      Log.d((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  /// Parameters
  Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }
}
