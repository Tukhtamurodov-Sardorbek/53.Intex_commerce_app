// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:intex_commerce/pages/home_page/home_controller.dart';
//
// class DioExceptions implements Exception{
//   final controller = Get.find<HomeController>();
//   DioExceptions.fromDioError(DioError error){
//     switch(error.type){
//       case DioErrorType.cancel:
//         controller.dioException = DioErrorType.cancel.name;
//         break;
//       case DioErrorType.connectTimeout:
//         // * Read from local
//         controller.dioException = DioErrorType.connectTimeout.name;
//         break;
//       case DioErrorType.receiveTimeout:
//         // * Kill the operation
//         controller.dioException = DioErrorType.receiveTimeout.name;
//         break;
//       case DioErrorType.response:
//         controller.dioException = _handleError(error.response?.statusCode ?? 0, error.response?.data ?? '');
//         break;
//       case DioErrorType.sendTimeout:
//       // * Kill the operation
//         controller.dioException = DioErrorType.sendTimeout.name;
//         break;
//       default:
//         controller.dioException = 'Something went wrong';
//         break;
//     }
//   }
//
//   String _handleError(int statusCode, dynamic error){
//     switch(statusCode){
//       case 400: return 'Bad Request';
//       case 401: return 'Unauthorized';
//       case 402: return 'Payment Required';
//       case 403: return 'Forbidden';
//       case 404: return 'Not Found';
//       case 405: return 'Method Not Allowed';
//       case 406: return 'Not Acceptable';
//       case 407: return 'Proxy Authentication Required';
//       case 408: return 'Request Timeout';
//       case 409: return 'Conflict';
//       case 410: return 'Gone';
//       case 411: return 'Length Required';
//       case 412: return 'Precondition Failed';
//       case 413: return 'Payload Too Large';
//       case 414: return 'URI Too Long';
//       case 415: return 'Unsupported Media Type';
//       case 416: return 'Range Not Satisfiable';
//       case 417: return 'Expectation Failed';
//       case 418: return 'I\'m a teapot';
//       case 421: return 'Misdirected Request';
//       case 422: return 'Unprocessable Entity';
//       case 423: return 'Locked';
//       case 424: return 'Failed Dependency';
//       case 425: return 'Too Early';
//       case 426: return 'Upgrade Required';
//       case 428: return 'Precondition Required';
//       case 429: return 'Too Many Requests';
//       case 431: return 'Request Header Fields Too Large';
//       case 451: return 'Unavailable For Legal Reasons';
//       default: return 'Something went wrong...';
//     }
//   }
// }