import 'package:get/get.dart';
import 'package:intex_commerce/data/dio_client.dart';
import 'package:intex_commerce/core/app_services/database_service.dart';
import 'package:intex_commerce/core/app_services/environment_service.dart';
import 'package:intex_commerce/core/app_services/log_service.dart';
import 'package:intex_commerce/data/models/category_list_model.dart';
import 'package:intex_commerce/data/models/products_model.dart';
import 'package:intex_commerce/pages/home_page/home_controller.dart';
import 'package:intex_commerce/routes/app_routes.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    fetchData(false);
    super.onInit();
  }

  Future<void> fetchData(bool isRefresh) async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if (hasInternet) {
      Log.i('Fetch');
      await Future.wait([getCategoryList(), getProductList()]).then((value) => Get.offNamed(AppRoutes.home));
    } else {
      if (StorageService.to.checkData(StorageKeys.categoryList) && StorageService.to.checkData(StorageKeys.productList)) {
        Log.i('Read');
        Get.offNamed(AppRoutes.home);
      } else {
        Log.i('No');
        Get.offNamed(AppRoutes.noInternet);
      }
    }
  }

  Future<String> getCategoryList() async {
    Log.i('GET CATEGORY LIST');
    await DioService().GET(
      api: Environment.envVariable('apiGetCategory'),
      params: DioService().paramsEmpty(),
    ).then((value) => {parseCategory(value)});
    return '';
  }
  void parseCategory(String? response) {
    if (response != null) {
      Log.i('PARSE CATEGORY LIST');
      CaterogyModel category = caterogyListModelFromJson(response);
      StorageService.to.setData(StorageKeys.categoryList, category.data);
    } else{
      Log.i('PARSE CATEGORY LIST');

    }
  }

  Future<String> getProductList() async {
    await DioService().GET(
      api: Environment.envVariable('apiGetProduct'),
      params: DioService().paramsEmpty(),
    ).then((value) => {parseProduct(value)});
    return '';
  }

  void parseProduct(String? response) {
    if (response != null) {
      ProductModel product = productModelFromJson(response);
      Log.i('SAVING PRODUCTS: ${product.data}');
      StorageService.to.setData(StorageKeys.productList, product.data);
    }
  }
}
