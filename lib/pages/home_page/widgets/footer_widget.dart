import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intex_commerce/core/app_utils/app_borders.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:intex_commerce/core/app_utils/app_spaces.dart';
import 'package:intex_commerce/core/app_utils/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intex_commerce/pages/home_page/home_controller.dart';
import 'package:intex_commerce/pages/home_page/widgets/icon_widgets.dart';
import 'package:intex_commerce/pages/home_page/widgets/text_fields.dart';

import 'dialog_widgets.dart';

class Footer extends StatelessWidget {

  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        GetBuilder<HomeController>(
          builder: (controller) {
            return Container(
              padding: AppSpaces.kTLRPadding,
              height: 387.h,
              width: 375.w,
              color: AppColors.main,
              child: Column(
                children: [
                  Text(
                    "get_free_consultation".tr,
                    style: AppTextStyles.size20weight700White,
                    textAlign: TextAlign.center,
                  ),
                  AppSpaces.spaceVertical12,
                   Padding(
                     padding: AppSpaces.kHorizontalPadding30,
                    child: TextFieldString(
                      next: true,
                      height: 37.h,
                      hint: "name".tr,

                      displayShadow: false,
                      isConsultDialog: false,
                      textController: controller.footerNameController,
                    ),
                  ),
                   AppSpaces.spaceVertical12,
                   Padding(
                     padding: AppSpaces.kHorizontalPadding30,
                     child: PhoneTextField(
                       next: false,
                       height: 37.h,
                       displayShadow: false,
                       isConsultDialog: false,
                       phoneController: controller.footerPhoneController,
                       hintText: "number".tr,
                     ),
                  ),
                  AppSpaces.spaceVertical12,
                  MaterialButton(
                    height: 37.h,
                    minWidth: 239.w,
                    shape: RoundedRectangleBorder(borderRadius: AppBorders.circular10),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      controller.openDialog(
                          context: context,
                          child: const ConsultDialog(),
                      );
                    },
                    color: AppColors.yellow,
                    child: Text(
                      'want_consult'.tr,
                      style: AppTextStyles.size15weight700Black,
                    ),
                  ),
                  AppSpaces.spaceVertical20,
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //Рабочее время
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //clock
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/png/icons/ic_clock.png',
                                      width: 27.0,
                                      height: 27.0,
                                    ),
                                    AppSpaces.spaceHorizontal8,
                                    Text(
                                      'working_time'.tr,
                                      style: AppTextStyles.size15weight700,
                                    ),
                                  ],
                                ),
                                AppSpaces.spaceVertical10,
                                Text(
                                  "weekdays".tr,
                                  style: AppTextStyles.size12weight700,
                                ),
                                AppSpaces.spaceVertical12,
                                const FooterIcons(),
                              ],
                            ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "address".tr,
                                style: AppTextStyles.size12weight700,
                              ),
                              AppSpaces.spaceVertical20,
                              FittedBox(
                                child: Text(
                                  "developed".tr,
                                  style: AppTextStyles.size10weight700,
                                ),
                              ),
                              Text(
                                "rights_reserved".tr,
                                style: AppTextStyles.size10weight700,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ]),
    );
  }
}
