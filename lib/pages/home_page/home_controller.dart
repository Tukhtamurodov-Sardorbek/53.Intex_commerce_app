import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intex_commerce/core/app_services/database_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intex_commerce/data/dio_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intex_commerce/data/models/info_model.dart';
import 'package:intex_commerce/pages/home_page/home_ui.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:intex_commerce/data/models/category_model.dart';
import 'package:intex_commerce/data/models/products_model.dart';
import 'package:intex_commerce/core/app_services/log_service.dart';
import 'package:intex_commerce/pages/splash_page/splash_controller.dart';
import 'package:intex_commerce/core/app_services/environment_service.dart';
import 'package:intex_commerce/pages/home_page/widgets/dialog_widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeController extends GetxController {
  // * Fields
  final scrollController = ScrollController();
  final footerNameController = TextEditingController();
  final footerPhoneController = TextEditingController();
  final consultNameController = TextEditingController();
  final consultPhoneController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  List<Map<int, List<Product>>> _products = [];
  DateTime _lastPressed = DateTime(0);
  List<CategoryData> _categories = [];
  bool _displayShadow = false;
  late String _language;
  String _dioException = '';
  bool _isPostingConsultation = false;
  bool _isPostingOrder = false;

  final _textBasseyn = <String>[
    'strength',
    'easy_to_install',
    'beautiful_and_vibrant_colors',
    'stylish_design',
    'high_quality',
  ];
  Info _info = Info(phoneNumber: '', addressRu: '', addressUz: '', workTimeRu: '', workTimeUz: '', telegramLink: '', instagramLink: '',);

  // * Getters & Setters
  List<Map<int, List<Product>>> get products => _products;
  List<CategoryData> get categories => _categories;
  String get language => _language;
  String get dioException => _dioException;
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
  set dioException(String msg) {
    if (_dioException != msg) {
      _dioException = msg;
      update();
    }
  }

  @override
  void onInit() {
    if (DatabaseService.checkDatabase(DatabaseKeys.language)) {
      _language = DatabaseService.loadString(DatabaseKeys.language) ?? 'ru';
    } else {
      _language = 'ru';
    }
    readData();
    super.onInit();
  }

  // * Methods
  readData() async {
    List<Product> productList = [];

    _info = DatabaseService.loadInfo() ?? _info;
    productList = DatabaseService.loadProducts();
    _categories = DatabaseService.loadCategories();

    // if (StorageService.to.getData(StorageKeys.info) is Info) {
    //   _info = StorageService.to.getData(StorageKeys.info);
    // } else {
    //   _info = Info.fromJson(StorageService.to.getData(StorageKeys.info));
    // }

    // if (StorageService.to.getData(StorageKeys.categoryList) is List<Category>) {
    //   _categories = StorageService.to.getData(StorageKeys.categoryList);
    // } else {
    //   if (StorageService.to.checkData(StorageKeys.categoryList)) {
    //     _categories = List<Category>.from(StorageService.to
    //         .getData(StorageKeys.categoryList)
    //         .map((x) => Category.fromJson(x)));
    //   }
    // }

    // if (StorageService.to.getData(StorageKeys.productList) is List<Product>) {
    //   productList = StorageService.to.getData(StorageKeys.productList);
    // } else {
    //   if (StorageService.to.checkData(StorageKeys.categoryList) &&
    //       StorageService.to.checkData(StorageKeys.productList)) {
    //     productList = List<Product>.from(StorageService.to
    //         .getData(StorageKeys.productList)
    //         .map((x) => Product.fromJson(x)));
    //   }
    // }
    _products.clear();
    update();

    for (int i = 0; i < _categories.length; i++) {
      Log.v("${_categories[i].id}");
      _products.add({
        _categories[i].id: productList.where((element) => element.categoryId == _categories[i].id)
            .toList()
      });
    }
    update();

    Log.i('READ INFO $_info');
    Log.i('READ CATEGORIES: $_categories');
    Log.i('READ PRODUCTS $_products');
  }

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
      final pos = 486 + productCardsHeight + superIndex * 80;
      scrollController.jumpTo(pos.h);
    }
  }
  bool _isDrawerOpen() => scaffoldKey.currentState!.isDrawerOpen;
  void openDrawer() => scaffoldKey.currentState!.openDrawer();
  void closeDrawer() => scaffoldKey.currentState!.closeDrawer();

  /// Url Launcher
  Future<void> _launchUrl(String url, bool isPhoneCall) async {
    if (isPhoneCall) {
      if (await canLaunch('tel:$url')) {
        await launch('tel:$url');
      }
    } else {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      }
    }
  }
  Future<void> launchPhoneCall() => _launchUrl(getPhoneCall(), true);
  Future<void> launchTelegram() => _launchUrl(_info.telegramLink, false);
  Future<void> launchInstagram() => _launchUrl(_info.instagramLink, false);

  /// Pull to refresh
  Future<void> handleRefresh() async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if(hasInternet){
      await _deleteCachedImages();
      Get.forceAppUpdate();
      Get.find<SplashController>().fetchData().then((value) => readData());
    }
  }
  // Clear cache
  Future _deleteCachedImages() async {
    List<String> urls = [];
    for(int superIndex = 0; superIndex < categories.length; superIndex++){
      for(int index = 0; index < products[superIndex][categories[superIndex].id]!.length; index++){
        urls.add(products[superIndex][categories[superIndex].id]![index].image);
      }
    }
    print('URLS: $urls');

    urls.map((url) async => await CachedNetworkImage.evictFromCache(url));
    for(int i = 0; i<urls.length; i++){
      await CachedNetworkImage.evictFromCache(urls[i]);
    }
    update();
  }

  /// Form price
  String price(String priceStr) {
    int remainder = priceStr.length % 3;
    String generate =
        remainder != 0 ? '${priceStr.substring(0, remainder)} ' : '';

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

  String getPhoneCall() {
    String phoneToCall = _info.phoneNumber.replaceAll(RegExp(r'[^\+\d]+'), '');
    if (phoneToCall.startsWith('998')) {
      phoneToCall = '+$phoneToCall';
      update();
    }
    return phoneToCall;
  }

  String getPhone() => _info.phoneNumber;
  String getAddress() => _language == 'uz' ? _info.addressUz : _info.addressRu;
  String getWorkTime() {
    String workTime = '';
    if (_language == 'uz') {
      workTime = _info.workTimeUz.replaceFirst('. ', '\n');
    } else {
      workTime = _info.workTimeRu.replaceFirst('. ', '\n');
    }
    return workTime;
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
    footerPhoneController.clear();
    footerNameController.clear();
    update();
  }

  /// Dialog
  Future<dynamic> openDialog({required BuildContext context, required Widget child}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => child,
    );
  }

  /// Network
  Future<void> postConsultation(BuildContext context, bool isFromFooter) async {
    late String name;
    late String phone;
    if (isFromFooter) {
      name = footerNameController.text.trim().toString();
      phone = footerPhoneController.text.trim().toString();
    } else {
      name = consultNameController.text.trim().toString();
      phone = consultPhoneController.text.trim().toString();
    }
    bool hasInternet = await InternetConnectionChecker().hasConnection;

    if (name.isNotEmpty && phone.length == 17 && phone.startsWith('+998')) {
      Log.w('PHONE: $phone');
      _isPostingConsultation = true;
      update();

      if (hasInternet) {
        final response = await DioService().POST(
          api: Environment.envVariable('apiCreateConsultation'),
          body: {"name": name, "phoneNumber": formPhoneNumber(phone)},
        );
        await _consultationResponse(response: response, context: context);
      } else {
        failureOnConsultation(context);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const WarningDialog(),
      );
      Timer(const Duration(seconds: 3), () => Get.back());
    }
  }

  Future<void> _consultationResponse({required String? response, required BuildContext context}) async {
    _isPostingConsultation = false;
    update();
    if (response != null) {
      Get.back();
      openDialog(
        context: context,
        child: const SuccessDialog(isConsult: true),
      );
      clearConsultTextControllers();
    } else {
      showDialog(
        context: context,
        builder: (context) => const FailDialog(),
      );
    }
  }

  Future<void> postOrder(BuildContext context, int productId) async {
    String name = nameController.text.trim().toString();
    String phone = phoneController.text.trim().toString();
    String address = addressController.text.trim().toString();
    bool hasInternet = await InternetConnectionChecker().hasConnection;

    if (name.isNotEmpty &&
        phone.length == 17 &&
        phone.startsWith('+998') &&
        address.isNotEmpty) {
      Log.w('PHONE: $phone');
      _isPostingOrder = true;
      update();

      if (hasInternet) {
        final response = await DioService().POST(
          api: Environment.envVariable('apiCreateOrder'),
          body: {
            "productId": productId,
            "name": name,
            "phoneNumber": formPhoneNumber(phone),
            "address": address,
          },
        );
        await _orderResponse(response: response, context: context);
      } else {
        failureOnOrdering(context);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const WarningDialog(),
      );
      Timer(const Duration(seconds: 3), () => Get.back());
    }
  }

  Future<void> _orderResponse({required String? response, required BuildContext context}) async {
    Log.wtf(response ?? 'NO ORDER RESPONSE');
    _isPostingOrder = false;
    update();

    if (response != null && response == '406') {
      openDialog(
        context: context,
        child: const OutOfStockDialog(),
      );
      clearTextControllers();
      handleRefresh();
    } else if (response != null) {
      Get.back();
      openDialog(
        context: context,
        child: const SuccessDialog(isConsult: false),
      );
      clearTextControllers();
    } else {
      showDialog(
        context: context,
        builder: (context) => const FailDialog(),
      );
    }
  }

  void failureOnConsultation(BuildContext ctr) {
    _isPostingConsultation = false;
    update();
    Get.back();
    showDialog(
      context: ctr,
      builder: (context) => const FailDialog(),
    );
  }

  void failureOnOrdering(BuildContext ctr) {
    _isPostingOrder = false;
    update();
    Get.back();
    showDialog(
      context: ctr,
      builder: (context) => const FailDialog(),
    );
  }

  formPhoneNumber(String phone) {
    if (phone.length == 17 && phone.startsWith('+998 ')) {
      phone = phone.replaceAll('+998 ', '');
      update();
    } else if (phone.length == 17 && phone.startsWith('+998')) {
      phone = phone.replaceFirst('+998', '');
    }
    return phone;
  }

  /// Localization
  void changeLanguage() {
    _language = _language == 'uz' ? 'ru' : 'uz';
    update();
    DatabaseService.storeString(DatabaseKeys.language, _language);
    Get.updateLocale(Locale(_language));
  }
}
