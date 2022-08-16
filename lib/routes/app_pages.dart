import 'package:get/get.dart';
import 'package:intex_commerce/pages/no_internet_connection_page/no_internet_ui.dart';
import 'package:intex_commerce/routes/app_routes.dart';
import 'package:intex_commerce/bindings/splash_binding.dart';
import 'package:intex_commerce/bindings/main_bindings.dart';
import 'package:intex_commerce/pages/home_page/home_ui.dart';
import 'package:intex_commerce/pages/splash_page/splash_ui.dart';

class AppPages {
  static final List<GetPage<String>> pages = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: AppRoutes.noInternet,
      page: () => const NoInternetConnectionPage(),
      binding: MainBindings(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: MainBindings(),
    ),
  ];
}