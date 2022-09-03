import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:intex_commerce/data/models/category_model.dart';
import 'package:intex_commerce/data/models/info_model.dart';
import 'package:intex_commerce/data/models/products_model.dart';

enum DatabaseKeys {
  language,
  categoryList,
  productList,
  info
}

class DatabaseService {
  static String DB_NAME = 'database';
  static Box box = Hive.box(DB_NAME);

  /// STRING
  static Future<void> storeString (DatabaseKeys key, String str) async {
    box.put(key.name, str);
  }
  static String? loadString(DatabaseKeys key){
    String? str = box.get(key.name, defaultValue: null);
    return str;
  }

  /// OBJECT
  static Future<void> storeInfo (Info info) async {
    box.put(DatabaseKeys.info.name, jsonEncode(info.toJson()));
  }
  static Info? loadInfo(){
    String? jsonData = box.get(DatabaseKeys.info.name, defaultValue: null);
    if(jsonData != null){
      Info info = Info.fromJson(jsonDecode(jsonData));
      return info;
    }
    return null;
  }

  /// LIST
  static Future<void> storeCategories (List<CategoryData> categories) async {
    List<String> stringList = categories.map((category) => jsonEncode(category.toJson())).toList();
    await box.put(DatabaseKeys.categoryList.name, stringList);
  }
  static List<CategoryData> loadCategories(){
    List<String>? stringList = box.get(DatabaseKeys.categoryList.name);
    if(stringList != null){
      List<CategoryData> categories = stringList.map((string) => CategoryData.fromJson(jsonDecode(string))).toList();
      return categories;
    }
    return <CategoryData>[];
  }

  static Future<void> storeProducts (List<Product> products) async {
    List<String> stringList = products.map((product) => jsonEncode(product.toJson())).toList();
    await box.put(DatabaseKeys.productList.name, stringList);
  }
  static List<Product> loadProducts(){
    List<String>? stringList = box.get(DatabaseKeys.productList.name);
    if(stringList != null){
      List<Product> products = stringList.map((string) => Product.fromJson(jsonDecode(string))).toList();
      return products;
    }
    return <Product>[];
  }

  static bool checkDatabase(DatabaseKeys key) {
    return box.containsKey(key.name);
  }

  static Future<void> clearDatabase(DatabaseKeys key) async {
    box.delete(key.name);
  }
}