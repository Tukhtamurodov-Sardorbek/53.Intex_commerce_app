import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:intex_commerce/core/app_utils/app_spaces.dart';
import 'package:intex_commerce/core/app_utils/app_text_styles.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
class LightLabel extends StatelessWidget {
  final String label;
  const LightLabel({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 46.h,
      color: AppColors.lightGreen,
      alignment: Alignment.center,
      child: Text(
        label,
        style: AppTextStyles.size23weight700Main,
      ),
    );
  }
}


class Label extends StatelessWidget {
  final String label;
  const Label({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: double.infinity, //MediaQuery.of(context).size.width,
      color: AppColors.main,
      alignment: Alignment.center,
      child: Text(label, style: AppTextStyles.size23weight700),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'free_shipping_pool'.tr,
            style: AppTextStyles.size18weight700Main,
          ),
          AppSpaces.spaceVertical5,
          Text(
            'value_our'.tr,
            style: AppTextStyles.size12weight400Main,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}