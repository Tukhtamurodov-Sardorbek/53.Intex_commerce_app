import 'package:intex_commerce/core/exports/splash_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if (hasInternet) {
      await Future.wait([
        SplashRepository.getCategoryList(),
        SplashRepository.getProductList(),
        SplashRepository.getInfo(),
      ]);
    }
    if(DatabaseService.checkDatabase(DatabaseKeys.categoryList) && DatabaseService.checkDatabase(DatabaseKeys.productList) && DatabaseService.checkDatabase(DatabaseKeys.info)){
      Get.offNamed(AppRoutes.home);
    } else {
      Get.offNamed(AppRoutes.noInternet);
    }
  }
}