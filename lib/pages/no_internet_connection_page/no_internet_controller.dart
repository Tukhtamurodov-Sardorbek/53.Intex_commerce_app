import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intex_commerce/data/api_client.dart';
import 'package:intex_commerce/core/app_services/environment_service.dart';
import 'package:intex_commerce/pages/splash_page/splash_controller.dart';
import 'package:intex_commerce/routes/app_routes.dart';

import '../../core/app_services/database_service.dart';
import '../../data/models/category_list_model.dart';
import '../../data/models/products_model.dart';

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
    InternetConnectionChecker().onStatusChange.listen(
        // (status) {hasInternet = status == InternetConnectionStatus.connected;}
        _updateConnectionStatus);
    super.onInit();
  }

  Future<void> _updateConnectionStatus(InternetConnectionStatus status) async {
    if (status == InternetConnectionStatus.connected) {
      await Future.wait([getCategoryList(), getProductModel()])
          .then((value) => Get.offNamed(AppRoutes.home));
    }
  }

  Future<String> getCategoryList() async {
    await DioService().get(
        api: Environment.envVariable('apiGetCategory'),
        params: DioService().paramsEmpty()).then((value) => {
          parseCategory(value),
    });
    return '';
  }

  void parseCategory(String? response) {
    if (response != null) {
      CaterogyModel caterogy = caterogyListModelFromJson(response);
      StorageService.to.setData(StorageKeys.categoryList, caterogy.data);
    }
  }

  Future<String> getProductModel() async {
    await DioService().get(
        api: Environment.envVariable('apiGetProduct'),
        params: DioService().paramsEmpty()).then(
            (value) => {parseProduct(value)},
    );
    return '';
  }

  void parseProduct(String? response) {
    if (response != null) {
      ProductModel product = productModelFromJson(response);
      StorageService.to.setData(StorageKeys.productList, product.data);
    }
  }

  Future<void> onPressed() async {
    isLoading = true;

    await Future.delayed(const Duration(milliseconds: 700));
    bool hasInternet = await InternetConnectionChecker().hasConnection;

    isLoading = false;

    if (hasInternet) {
      Future.wait([
        Get.find<SplashController>().getCategoryList(),
        Get.find<SplashController>().getProductList(),
      ]).then((value) => Get.offNamed(AppRoutes.home));
    }
  }
}
