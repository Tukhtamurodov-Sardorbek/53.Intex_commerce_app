import 'package:flutter/material.dart';
import 'package:intex_commerce/core/exports/no_internet_ui.dart';

class NoInternetConnectionPage extends GetView<NoInternetConnectionController> {
  const NoInternetConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GetBuilder<NoInternetConnectionController>(builder: (ctr) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(36),
                        child: Image.asset(
                          'assets/png/local/no_internet.png',
                          height: 310.h,
                          width: 306.w,
                        ),
                      ),
                      Text(
                        'internet_title'.tr,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppSpaces.spaceVertical12,
                      Text(
                        'internet_subtitle'.tr,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: AppSpaces.kAllPadding17,
                  child: MaterialButton(
                    height: 50.h,
                    minWidth: double.infinity,
                    color: AppColors.main,
                    shape: RoundedRectangleBorder(
                        borderRadius: AppBorders.circular10),
                    onPressed: () {
                      controller.onPressed();
                    },
                    child: controller.isLoading
                        ? Theme(
                            data: ThemeData(
                              cupertinoOverrideTheme: const CupertinoThemeData(
                                brightness: Brightness.light,
                              ),
                            ),
                            child: CupertinoActivityIndicator(
                              radius: 12.r,
                              color: AppColors.white,
                              animating: true,
                            ),
                          )
                        : Center(
                            child: Text(
                              'try_again'.tr,
                              style: const TextStyle(
                                color: AppColors.white,
                                letterSpacing: 1,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
