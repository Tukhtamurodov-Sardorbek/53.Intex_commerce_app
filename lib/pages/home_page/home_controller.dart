import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:intex_commerce/data/api_client.dart';
import 'package:intex_commerce/core/app_services/database_service.dart';
import 'package:intex_commerce/core/app_services/environment_service.dart';
import 'package:intex_commerce/core/app_services/log_service.dart';
import 'package:intex_commerce/data/models/category_list_model.dart';
import 'package:intex_commerce/data/models/products_model.dart';
import 'package:intex_commerce/pages/home_page/home_ui.dart';
import 'package:intex_commerce/pages/home_page/widgets/dialog_widgets.dart';
import 'package:intex_commerce/pages/splash_page/splash_controller.dart';
import 'package:intex_commerce/translations/app_translations.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  // * Fields
  final scrollController = ScrollController();

  final footerNameController = TextEditingController();
  final footerPhoneController = MaskedTextController(mask: '00 000 00 00');

  final consultNameController = TextEditingController();
  final consultPhoneController = MaskedTextController(mask: '00 000 00 00');

  final nameController = TextEditingController();
  final phoneController = MaskedTextController(mask: '00 000 00 00');
  final addressController = TextEditingController();

  List<Map<int, List<Product>>> _products = [];
  DateTime _lastPressed = DateTime(0);
  List<Category> _categories = [];
  bool _displayShadow = false;
  String _language = 'ru';
  bool _isPostingConsultation = false;
  bool _isPostingOrder = false;

  final _textBasseyn = <String>[
    'strength',
    'easy_to_install',
    'beautiful_and_vibrant_colors',
    'stylish_design',
    'high_quality',
  ];

  // * Getters & Setters
  List<Map<int, List<Product>>> get products => _products;
  List<Category> get categories => _categories;
  String get language => _language;
  List<String> get textPools => _textBasseyn;

  bool get displayShadow => _displayShadow;
  bool get isPostingConsultation => _isPostingConsultation;
  bool get isPostingOrder => _isPostingOrder;

  set displayShadow(bool value) {
    if (_displayShadow != value) {
      _displayShadow = value;
      update();
    }
  }
  set isPostingOrder(bool value) {
    if (_isPostingOrder != value) {
      _isPostingOrder = value;
      update();
    }
  }

  @override
  void onInit() {
    readData();
    super.onInit();
  }

  // * Methods
  /// Will Pop Scope
  Future<bool> doubleTapToClose() async {
    final now = DateTime.now();
    const maxDuration = Duration(seconds: 2);
    final isWarning = now.difference(_lastPressed) > maxDuration;

    if (_isDrawerOpen()) {
      closeDrawer();
      return false;
    } else if (isWarning) {
      _lastPressed = DateTime.now();
      update();
      return false;
    } else {
      return true;
    }
  }

  /// Drawer
  Future<void> scrollToPosition(int superIndex) async {
    closeDrawer();
    if (superIndex == 0) {
      scrollController.jumpTo(486.h);
    } else {
      double productCardsHeight = 0;
      for (int i = 0; i < superIndex; i++) {
        productCardsHeight += _products[i][_categories[i].id]!.length * 255;
      }
      // final pos = 565 + productCardsHeight;
      final pos = 486 + productCardsHeight + superIndex * 80; //80
      scrollController.jumpTo(pos.h);
    }
  }
  bool _isDrawerOpen() {
    bool isOpen = scaffoldKey.currentState!.isDrawerOpen;
    return isOpen;
  }
  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }
  void closeDrawer() {
    scaffoldKey.currentState!.closeDrawer();
  }

  /// Url Launcher
  // void call() async {
  //   const phoneNumber = '+998907997720';
  //   const url = 'tel:$phoneNumber';
  // }

  Future<void> _launchUrl(String url, bool isPhoneCall) async {
    if(isPhoneCall){
      if (await canLaunch(url)) {
        await launch(url);
      }
    }else{
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      }
    }
  }

  Future<void> launchPhoneCall() => _launchUrl(Environment.envVariable('phone'), true);
  Future<void> launchTelegram() => _launchUrl(Environment.envVariable('telegram'), false);
  Future<void> launchInstagram() => _launchUrl(Environment.envVariable('instagram'), false);

  /// Pull to refresh
  Future<void> handleRefresh() async {
    return Get.find<SplashController>().fetchData(true).then((value) => readData());
  }

  /// Form price
  String price(String priceStr) {
    int remainder = priceStr.length % 3;
    String generate = remainder != 0 ? '${priceStr.substring(0, remainder)} ' : '';

    for (int i = remainder; i < priceStr.length; i++) {
      if (i != 0 && (i - remainder + 1) % 3 == 0) {
        generate += '${priceStr[i]} ';
      } else {
        generate += priceStr[i];
      }
    }
    return generate;
  }

  /// Get Data
  String getStatus({required int superIndex, required int categoryId, required int index}) {
    return _language == 'uz'
        ? _products[superIndex][categoryId]![index].statusUz
        : _products[superIndex][categoryId]![index].statusRu;
  }
  String getProductName({required int superIndex, required int categoryId, required int index}) {
    return _language == 'uz'
        ? _products[superIndex][categoryId]![index].frameUz
        : _products[superIndex][categoryId]![index].frameRu;
  }
  String getProductCategoryName({required int superIndex, required int categoryId, required int index}) {
    return _language == 'uz'
        ? _products[superIndex][categoryId]![index].categoryNameUz
        : _products[superIndex][categoryId]![index].categoryNameRu;
  }
  String getCategoryName({required int superIndex}) {
    return _language == 'uz'
        ? _categories[superIndex].nameUz
        : _categories[superIndex].nameRu;
  }
  Color getStatusColor({required int superIndex, required int categoryId, required int index}) {
    final id = _products[superIndex][categoryId]![index].statusId;
    switch (id) {
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.yellow;
      case 3:
        return AppColors.red;
      default:
        return AppColors.transparent;
    }
  }

  /// Text Controllers
  void clearTextControllers() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    update();
  }
  void clearConsultTextControllers() {
    consultNameController.clear();
    consultPhoneController.clear();
    update();
  }

  /// Dialog
  Future<dynamic> openDialog({required BuildContext context, required Widget child}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => child,
    );
  }

  readData() async {
    List<Product> productList = [];
    if (StorageService.to.getData(StorageKeys.productList) is List<Product>) {
      _categories = StorageService.to.getData(StorageKeys.categoryList);
      productList = StorageService.to.getData(StorageKeys.productList);
    } else {
      _categories = List<Category>.from(StorageService.to.getData(StorageKeys.categoryList).map((x) => Category.fromJson(x)));
      productList = List<Product>.from(StorageService.to.getData(StorageKeys.productList).map((x) => Product.fromJson(x)));
    }
    _products.clear();
    update();

    for (int i = 0; i < _categories.length; i++) {
      _products.add({
        _categories[i].id: productList.where((element) => element.categoryId == _categories[i].id).toList()
      });
    }
    update();
    Log.i('READ CATEGORIES: $_categories');
    Log.i('READ PRODUCTS $_products');
  }

  /// Network
  void consultationResponse({required String? response, required BuildContext context}) {
    Get.back();
    if (response != null) {
      _isPostingConsultation = false;
      update();
      openDialog(
        context: context,
        child: const SuccessDialog(),
      );
      clearConsultTextControllers();
    }
  }
  void orderResponse({required String? response, required BuildContext context}) {
    Log.wtf(response ?? 'NO RESPONSE');

    if(response == '406'){
      _isPostingOrder = false;
      update();
      openDialog(
        context: context,
        child: const OutOfStockDialog(),
      );
      clearTextControllers();
    }
    else if (response != null) {
      _isPostingOrder = false;
      update();
      openDialog(
        context: context,
        child: const SuccessDialog(),
      );
      clearTextControllers();
    }
  }


  Future<void> postConsultation(BuildContext context) async {
    String name = consultNameController.text.trim().toString();
    String phone = consultPhoneController.text.trim().toString();
    bool hasInternet = await InternetConnectionChecker().hasConnection;

    if (name.isNotEmpty && phone.length == 12) {
      _isPostingConsultation = true;
      update();

      if(hasInternet){
        await DioService().POST(
            api: Environment.envVariable('apiCreateConsultation'),
            params: {
              "name": name,
              "phoneNumber": phone,
            }).then((value) => {
              consultationResponse(context: context, response: value),
        });
      }else{
        _isPostingConsultation = false;
        update();
        Get.back();
        showDialog(
          context: context,
          builder: (context) => const FailDialog(),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const WarningDialog(),
      );
      Timer(const Duration(seconds: 1), () => Get.back());
    }
  }

  Future<void> postOrder(BuildContext context, int productId) async {
    String name = nameController.text.trim().toString();
    String phone = phoneController.text.trim().toString();
    String address = addressController.text.trim().toString();
    bool hasInternet = await InternetConnectionChecker().hasConnection;

    if (name.isNotEmpty && phone.length == 12 && address.isNotEmpty) {
      Log.wtf("$phone => ${phone.length}");
      _isPostingOrder = true;
      update();
      if(hasInternet){
        await DioService().POST(
            api: Environment.envVariable('apiCreateOrder'),
            params: {
              "productId": productId,
              "name": name,
              "phoneNumber": phone,
              "address": address,
            }).then((value) => {
              orderResponse(context: context, response: value),
        });
      }else{
        _isPostingOrder = false;
        update();
        Get.back();
        showDialog(
          context: context,
          builder: (context) => const FailDialog(),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const WarningDialog(),
      );
      Timer(const Duration(seconds: 1), () => Get.back());
    }
  }


  /// Localization
  void changeLanguage() {
    _language = _language == 'uz' ? 'ru' : 'uz';
    update();
    AppTranslations.changeLocale(_language);
  }
}
