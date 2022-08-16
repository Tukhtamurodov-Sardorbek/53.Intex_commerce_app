import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intex_commerce/core/app_utils/app_borders.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:intex_commerce/core/app_utils/app_spaces.dart';
import 'package:intex_commerce/core/app_utils/box_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intex_commerce/pages/home_page/home_controller.dart';

class IconWidget extends StatelessWidget {
  final String img;
  final double height;
  final double width;
  final bool background;
  final void Function() onTap;

  const IconWidget({
    Key? key,
    required this.img,
    required this.height,
    required this.width,
    required this.background,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: background
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height,
                  width: width,
                  padding: AppSpaces.kAllPadding3,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppBorders.circular8,
                      boxShadow: [appBoxShadowIcon()]),
                  child: Center(
                    child: Image.asset(img),
                  ),
                ),
              ],
            )
          : Image.asset(img, height: 18.h, width: 22.w),
    );
  }
}

// * Sliver App Bar Icons
class AppBarActions extends StatelessWidget {
  const AppBarActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Row(
          children: [
            IconWidget(
              img: 'assets/png/icons/ic_phone.png',
              height: 25.h,
              width: 25.w,
              background: true,
              onTap: () => controller.launchPhoneCall(),
            ),
            AppSpaces.spaceHorizontal15,
            IconWidget(
              img: 'assets/png/icons/ic_telegram.png',
              height: 25.h,
              width: 25.w,
              background: true,
              onTap: () => controller.launchTelegram(),
            ),
            AppSpaces.spaceHorizontal15,
            IconWidget(
              img: controller.language == "uz"
                  ? 'assets/png/icons/ic_ru.png'
                  : "assets/png/icons/ic_uz.png",
              height: 25.h,
              width: 25.w,
              background: true,
              onTap: () {
                controller.changeLanguage();
              },
            ),
            AppSpaces.spaceHorizontal15,
            IconWidget(
              img: 'assets/png/icons/ic_menu.png',
              height: 18.h,
              width: 22.w,
              background: false,
              onTap: () => controller.openDrawer(),
            ),
            AppSpaces.spaceHorizontal8,
          ],
        );
      },
    );
  }
}

// * Footer Icons
class FooterIcons extends StatelessWidget {
  const FooterIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Row(
        children: [
          IconWidget(
            img: 'assets/png/icons/ic_phone.png',
            height: 29,
            width: 29,
            background: true,
            onTap: () => controller.launchPhoneCall(),
          ),
          AppSpaces.spaceHorizontal15,
          IconWidget(
            img: 'assets/png/icons/ic_telegram.png',
            height: 29,
            width: 29,
            background: true,
            onTap: () => controller.launchTelegram(),
          ),
          AppSpaces.spaceHorizontal15,
          IconWidget(
            img: 'assets/png/icons/ic_instagram.png',
            height: 29,
            width: 29,
            background: true,
            onTap: () {
              controller.launchInstagram();
            },
          ),
        ],
      );
    },);
  }
}

class CloseIconButton extends StatelessWidget {
  final void Function() onTap;

  const CloseIconButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                onTap();
                Get.back();
              },
              child: Padding(
                padding: AppSpaces.kRightPadding17,
                child: Image.asset(
                  'assets/png/icons/ic_close.png',
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
