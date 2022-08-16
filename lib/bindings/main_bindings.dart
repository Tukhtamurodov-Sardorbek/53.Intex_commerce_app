import 'package:get/get.dart';
import 'package:intex_commerce/pages/home_page/home_controller.dart';
import 'package:intex_commerce/pages/no_internet_connection_page/no_internet_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => NoInternetConnectionController(), fenix: true);
  }
}