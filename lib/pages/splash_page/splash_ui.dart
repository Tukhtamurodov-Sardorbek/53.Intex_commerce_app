import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:intex_commerce/pages/splash_page/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<SplashController>(builder: (ctr) {
        return Center(
          child: Image.asset(
            'assets/png/local/logo.jpg',
            fit: BoxFit.fitWidth,
          ),
        );
      }),
    );
  }
}
