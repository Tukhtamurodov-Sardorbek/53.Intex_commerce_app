import 'package:get/get.dart';
import 'package:intex_commerce/pages/splash_page/splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
  }
}