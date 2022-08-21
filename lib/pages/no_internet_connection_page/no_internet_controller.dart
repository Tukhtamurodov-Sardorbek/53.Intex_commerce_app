import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intex_commerce/pages/splash_page/splash_controller.dart';


class NoInternetConnectionController extends GetxController {
  bool _isLoading = false;

  set isLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      update();
    }
  }

  bool get isLoading => _isLoading;

  @override
  void onInit() {
    InternetConnectionChecker().onStatusChange.listen(_updateConnectionStatus);
    super.onInit();
  }

  Future<void> _updateConnectionStatus(InternetConnectionStatus status) async {
    if (status == InternetConnectionStatus.connected) {
      Get.find<SplashController>().fetchData(false);
    }
  }

  Future<void> onPressed() async {
    isLoading = true;

    await Future.delayed(const Duration(milliseconds: 700));
    bool hasInternet = await InternetConnectionChecker().hasConnection;

    isLoading = false;

    if (hasInternet) {
      Get.find<SplashController>().fetchData(false);
    }
  }
}
