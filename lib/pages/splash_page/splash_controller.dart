import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intex_commerce/core/app_services/database_service.dart';
import 'package:intex_commerce/data/dio_client.dart';
import 'package:intex_commerce/core/app_services/storage_service.dart';
import 'package:intex_commerce/core/app_services/environment_service.dart';
import 'package:intex_commerce/core/app_services/log_service.dart';
import 'package:intex_commerce/data/models/category_model.dart';
import 'package:intex_commerce/data/models/info_model.dart';
import 'package:intex_commerce/data/models/products_model.dart';
import 'package:intex_commerce/pages/home_page/home_controller.dart';
import 'package:intex_commerce/routes/app_routes.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if (hasInternet) {
      await Future.wait([getCategoryList(), getProductList(), getInfo()]).then((value){
        if(DatabaseService.checkDatabase(DatabaseKeys.categoryList) && DatabaseService.checkDatabase(DatabaseKeys.productList) && DatabaseService.checkDatabase(DatabaseKeys.info)){
          Get.offNamed(AppRoutes.home);
        } else {
          Get.offNamed(AppRoutes.noInternet);
        }
      });
    } else {
      if(DatabaseService.checkDatabase(DatabaseKeys.categoryList) && DatabaseService.checkDatabase(DatabaseKeys.productList) && DatabaseService.checkDatabase(DatabaseKeys.info)){
        Get.offNamed(AppRoutes.home);
      } else {
        Get.offNamed(AppRoutes.noInternet);
      }
    }
  }

  Future<String> getCategoryList() async {
    await DioService().GET(
      api: Environment.envVariable('apiGetCategory'),
      params: DioService().paramsEmpty(),
    ).then((value) => parseCategory(value));
    return '';
  }
  void parseCategory(String? response) {
    if (response != null) {
      CaterogyModel category = caterogyListModelFromJson(response);
      Log.i('SAVING CATEGORY: ${category.string()}');
      DatabaseService.storeCategories(category.data);
    }
  }

  Future<String> getProductList() async {
    await DioService().GET(
      api: Environment.envVariable('apiGetProduct'),
      params: DioService().paramsEmpty(),
    ).then((value) => parseProduct(value));
    return '';
  }
  void parseProduct(String? response) {
    if (response != null) {
      ProductModel product = productModelFromJson(response);
      Log.i('SAVING PRODUCTS: ${product.string()}');
      DatabaseService.storeProducts(product.data);
    }
  }

  Future<String> getInfo() async {
    await DioService().GET(
      api: Environment.envVariable('apiGetInfo'),
      params: DioService().paramsEmpty(),
    ).then((value) => parseInfo(value));
    return '';
  }
  void parseInfo(String? response) {
    if (response != null) {
      InfoModel info = infoModelFromJson(response);
      Log.i('SAVING INFO: ${info.data.first.toString()}');
      DatabaseService.storeInfo(info.data.first);
    }
  }
}