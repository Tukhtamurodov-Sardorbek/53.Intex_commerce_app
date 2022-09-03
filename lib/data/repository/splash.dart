import 'package:intex_commerce/data/models/info_model.dart';
import 'package:intex_commerce/data/provider/dio_client.dart';
import 'package:intex_commerce/data/models/category_model.dart';
import 'package:intex_commerce/data/models/products_model.dart';
import 'package:intex_commerce/data/local/database_service.dart';
import 'package:intex_commerce/core/app_services/log_service.dart';
import 'package:intex_commerce/core/app_services/environment_service.dart';

class SplashRepository{
  static Future<String> getCategoryList() async {
    await DioService().GET(
      api: Environment.envVariable('apiGetCategory'),
      params: DioService().paramsEmpty(),
    ).then((value) => _parseCategory(value));
    return '';
  }
  static void _parseCategory(String? response) {
    if (response != null) {
      CaterogyModel category = caterogyListModelFromJson(response);
      Log.i('SAVING CATEGORY: ${category.string()}');
      DatabaseService.storeCategories(category.data);
    }
  }

  static Future<String> getProductList() async {
    await DioService().GET(
      api: Environment.envVariable('apiGetProduct'),
      params: DioService().paramsEmpty(),
    ).then((value) => _parseProduct(value));
    return '';
  }
  static void _parseProduct(String? response) {
    if (response != null) {
      ProductModel product = productModelFromJson(response);
      Log.i('SAVING PRODUCTS: ${product.string()}');
      DatabaseService.storeProducts(product.data);
    }
  }

  static Future<String> getInfo() async {
    await DioService().GET(
      api: Environment.envVariable('apiGetInfo'),
      params: DioService().paramsEmpty(),
    ).then((value) => _parseInfo(value));
    return '';
  }
  static void _parseInfo(String? response) {
    if (response != null) {
      InfoModel info = infoModelFromJson(response);
      Log.i('SAVING INFO: ${info.data.first.toString()}');
      DatabaseService.storeInfo(info.data.first);
    }
  }
}
