import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:intex_commerce/core/app_utils/app_spaces.dart';
import 'package:intex_commerce/core/app_utils/app_borders.dart';
import 'package:intex_commerce/core/app_utils/app_text_styles.dart';
import 'package:intex_commerce/pages/home_page/home_controller.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.main,
      child: GetBuilder<HomeController>(
        builder: (controller) {
          return SafeArea(
            child: Padding(
              padding: AppSpaces.kLTRBPadding24202430,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(
                            'INTEX-MARKET.UZ',
                            style: AppTextStyles.size25weight700,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // AppSpaces.spaceVertical100,
                        SizedBox(
                          height: 240.h,
                          child: ListView.separated(
                            padding: AppSpaces.kTopPadding25,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.categories.length > 3
                                ? 3
                                : controller.categories.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DrawerButton(
                                isTextButtonOnly: true,
                                buttonText: controller.getCategoryName(
                                    superIndex: index),
                                appTextStyle: AppTextStyles.size17weight700,
                                onTap: () => controller.scrollToPosition(index),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return AppSpaces.spaceVertical24;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DrawerButton(
                          buttonText: 'call'.tr,
                          isTextButtonOnly: false,
                          image: 'assets/png/icons/ic_call.png',
                          appTextStyle: AppTextStyles.size21weight700White,
                          onTap: () => controller.launchPhoneCall(),
                        ),
                        AppSpaces.spaceVertical30,
                        DrawerButton(
                          buttonText: 'telegram'.tr,
                          isTextButtonOnly: false,
                          image: 'assets/png/icons/ic_telegram.png',
                          appTextStyle: AppTextStyles.size21weight700,
                          onTap: () => controller.launchTelegram(),
                        ),
                        AppSpaces.spaceVertical30,
                        DrawerButton(
                          buttonText: 'instagram'.tr,
                          isTextButtonOnly: false,
                          image: 'assets/png/icons/ic_instagram.png',
                          appTextStyle: AppTextStyles.size21weight700,
                          onTap: () => controller.launchInstagram(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final String buttonText;
  final String? image;
  final TextStyle appTextStyle;
  final void Function() onTap;
  final bool isTextButtonOnly;

  const DrawerButton({
    Key? key,
    this.image,
    required this.isTextButtonOnly,
    required this.buttonText,
    required this.appTextStyle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: buttonText == "call".tr ? AppColors.green : AppColors.white,
        fixedSize: Size.fromHeight(50.h),
        shape: RoundedRectangleBorder(borderRadius: AppBorders.circular10),
        splashFactory: NoSplash.splashFactory,
      ),
      child: isTextButtonOnly
          ? Center(
              child: Text(
                buttonText,
                style: AppTextStyles.size17weight700,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonText == "instagram".tr
                    ? Image.asset(image!, width: 30.w, height: 30.h)
                    : Image.asset(image!, width: 27.w, height: 24.h),
                AppSpaces.spaceHorizontal20,
                Text(buttonText, style: appTextStyle)
              ],
            ),
    );
  }
}
