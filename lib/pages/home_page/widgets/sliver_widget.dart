import 'package:flutter/material.dart';
import 'package:intex_commerce/core/app_utils/app_borders.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:intex_commerce/core/app_utils/app_spaces.dart';
import 'package:intex_commerce/core/app_utils/app_text_styles.dart';
import 'package:intex_commerce/core/app_utils/box_shadow.dart';
import 'package:intex_commerce/pages/home_page/home_controller.dart';
import 'package:intex_commerce/pages/home_page/widgets/dialog_widgets.dart';
import 'package:intex_commerce/pages/home_page/widgets/label_widget.dart';
import 'check_icons_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverWidget extends StatelessWidget {
  SliverWidget({Key? key}) : super(key: key);
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          // * Бесплатная доставка
          Padding(
            padding: AppSpaces.kTBPadding,
            child: Container(
              height: 201.h,
              width: 375.w,
              color: AppColors.main,
              padding: AppSpaces.kLTRBPadding14201420,
              child: Column(
                children: [
                  Text(
                    "free_shipping_title".tr,
                    style: AppTextStyles.size25weight700,
                  ),
                  AppSpaces.spaceVertical15,
                  Text(
                    "free_shipping".tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.size13weight700,
                  ),
                  AppSpaces.spaceVertical30,
                  Container(
                    height: 24.h,
                    width: 167.w,
                    decoration: BoxDecoration(boxShadow: [appBoxShadowIcon()]),
                    child: MaterialButton(
                      onPressed: () {
                        controller.openDialog(
                          context: context,
                          child: const ConsultDialog(),
                        );
                      },
                      shape: RoundedRectangleBorder(borderRadius: AppBorders.circular10),
                      padding: EdgeInsets.zero,
                      color: AppColors.yellow,
                      child: Text(
                        'checkout'.tr,
                        style: AppTextStyles.size15weight700Black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // * Ценности наших клиентов
          Padding(
            padding: AppSpaces.kBottomPadding44,
            child: LightLabel(label: 'appreciate_customers'.tr),
          ),

          //ListTile Widget
          Padding(
            padding: AppSpaces.kBottomPadding44,
            child: Column(
              children: [
                ListTile(
                  leading: Image.asset(
                    'assets/png/icons/ic_master.png',
                    height: 68.h,
                    width: 80.w,
                  ),
                  title: Text('experience'.tr,
                      style: AppTextStyles.size20weight700Black),
                  subtitle: Text(
                    'experience_review'.tr,
                    style: AppTextStyles.size13weight400Black,
                  ),
                ),
                AppSpaces.spaceVertical20,
                ListTile(
                  leading: Image.asset(
                    'assets/png/icons/ic_truck.png',
                    height: 70.h,
                    width: 80.w,
                  ),
                  title: Text('delivery'.tr,
                      style: AppTextStyles.size20weight700Black),
                  subtitle: Text(
                    'free_shipping_city'.tr,
                    style: AppTextStyles.size13weight400Black,
                  ),
                ),
                AppSpaces.spaceVertical20,
                ListTile(
                  leading: Image.asset(
                    'assets/png/icons/ic_certify.png',
                    height: 80.h,
                    width: 80.w,
                  ),
                  title: Text('quality'.tr,
                      style: AppTextStyles.size20weight700Black),
                  subtitle: Text(
                    'quality_review'.tr,
                    style: AppTextStyles.size13weight400Black,
                  ),
                )
              ],
            ),
          ),

          //Бассейны от intex в Ташкенте
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: LightLabel(label: "pools_tashkent".tr),
          ),

          Padding(
            padding: AppSpaces.kHorizontalPadding30,
            child: Column(
              children: [
                Text(
                  "pools_tashkent_review".tr,
                  style: AppTextStyles.size13weight400Black,
                ),
                AppSpaces.spaceVertical10,
                Text(
                  'pools_tashkent_review_second'.tr,
                  style: AppTextStyles.size13weight400Black,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.textPools.length,
                    itemBuilder: (context, index) {
                      return CheckIconsWidget(
                        aboutPoolsText: controller.textPools[index].tr,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
