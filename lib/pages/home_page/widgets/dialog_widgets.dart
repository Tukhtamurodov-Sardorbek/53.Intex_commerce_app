import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intex_commerce/core/app_services/log_service.dart';
import 'package:intex_commerce/core/app_utils/app_spaces.dart';
import 'package:intex_commerce/pages/home_page/widgets/icon_widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:intex_commerce/core/app_utils/box_shadow.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:intex_commerce/core/app_utils/app_borders.dart';
import 'package:intex_commerce/core/app_utils/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intex_commerce/pages/home_page/home_controller.dart';
import 'package:intex_commerce/pages/home_page/widgets/text_fields.dart';
import 'package:shimmer/shimmer.dart';

class ProductPreview extends StatelessWidget {
  final String title;
  final Widget child;
  const ProductPreview({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 171.h,
      width: 253.w,
      alignment: Alignment.center,
      padding: AppSpaces.kAllPadding17,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [appBoxShadowCard()],
        borderRadius: AppBorders.circularTrBlBr35,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.size15weight700Main,
          ),
          AppSpaces.spaceVertical5,
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}


class OrderDialog extends StatelessWidget {
  final String title;
  final String image;
  final String id;
  final String price;

  const OrderDialog({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.price
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: AppSpaces.kHorizontalPadding22,
      backgroundColor: AppColors.dialogBackground,
      insetAnimationCurve: Curves.bounceIn,
      shape: RoundedRectangleBorder(borderRadius: AppBorders.circular35),
      child: GetBuilder<HomeController>(builder: (controller) {
        return SizedBox(
          height: 520.h,
          width: 331.w,
          child: SingleChildScrollView(
            padding: AppSpaces.kTBPadding1725,
            child: Column(
              children: [
                CloseIconButton(onTap: controller.clearTextControllers),
                SizedBox(
                  height: 171.h,
                  width: 253.w,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    imageBuilder: (BuildContext context, ImageProvider imageProvider){
                      return ProductPreview(
                        title: title,
                        child: Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return Shimmer.fromColors(
                        baseColor: AppColors.main.withOpacity(0.7),
                        highlightColor: AppColors.main.withOpacity(0.3),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: AppBorders.circularTrBlBr35,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return ProductPreview(
                        title: title,
                        child: Center(
                          child: Image.asset('assets/png/icons/ic_no_image.png'),
                        ),
                      );
                    },
                  ),
                ),
                AppSpaces.spaceVertical30,
                Center(child: Text(price, style: AppTextStyles.size20weight700)),
                Padding(
                  padding: AppSpaces.kLTRBPadding32202713,
                  child: TextFieldString(
                    next: true,
                    height: 44.h,
                    displayShadow: true,
                    hint: 'your_name'.tr,
                    isConsultDialog: false,
                    textController: controller.nameController,
                  ),
                ),
                Padding(
                  padding: AppSpaces.kLRPadding,
                  child: PhoneTextField(
                    next: true,
                    height: 44.h,
                    displayShadow: true,
                    isConsultDialog: false,
                    phoneController: controller.phoneController,
                  ),
                ),
                Padding(
                  padding: AppSpaces.kTLRPadding133227,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFieldString(
                          next: false,
                          height: 44.h,
                          displayShadow: true,
                          isConsultDialog: false,
                          hint: 'your_address'.tr,
                          textController: controller.addressController,
                        ),
                      ),
                      AppSpaces.spaceHorizontal15,
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 46.h,
                          width: 46.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: AppBorders.circular17,
                              boxShadow: [appBoxShadowTextField()]),
                          child: Center(
                            child: Image.asset(
                              'assets/png/icons/ic_map.png',
                              height: 25.h,
                              width: 29.w,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                AppSpaces.spaceVertical24,
                MaterialButton(
                  padding: EdgeInsets.zero,
                  shape:
                  RoundedRectangleBorder(borderRadius: AppBorders.circular10),
                  minWidth: 178.w,
                  height: 36.h,
                  color: AppColors.yellow,
                  onPressed: () {
                    if(controller.isPostingOrder == false){
                      controller.postOrder(context, id);
                    }
                  },
                  child: controller.isPostingOrder
                      ? const CupertinoActivityIndicator(color: AppColors.black)
                      : Text(
                    'order'.tr,
                    style: AppTextStyles.size20weight700Black,
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

class ConsultDialog extends StatelessWidget {
  const ConsultDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.dialogBackground,
      insetAnimationCurve: Curves.bounceIn,
      shape: RoundedRectangleBorder(borderRadius: AppBorders.circular35),
      child: GetBuilder<HomeController>(builder: (controller) {
        return Container(
          height: 436.h,
          width: 330.w,
          padding: AppSpaces.kTBPadding1725,
          child: Column(
            children: [
              CloseIconButton(onTap: controller.clearConsultTextControllers),
              Image.asset(
                "assets/png/icons/ic_operator.png",
                height: 97.h,
                width: 91.w,
              ),
              AppSpaces.spaceVertical20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'get_consultation'.tr,
                    style: AppTextStyles.size20weight700,
                  ),
                ],
              ),
              Padding(
                padding: AppSpaces.kLTRBPadding32202713,
                child: TextFieldString(
                  height: 46.h,
                  next: true,
                  hint: 'your_name'.tr,
                  displayShadow: true,
                  isConsultDialog: true,
                  textController: controller.consultNameController,
                ),
              ),
              Padding(
                padding: AppSpaces.kLRPadding,
                child: PhoneTextField(
                  next: true,
                  height: 46.h,
                  displayShadow: true,
                  isConsultDialog: true,
                  phoneController: controller.consultPhoneController,
                ),
              ),
              AppSpaces.spaceVertical24,
              MaterialButton(
                height: 36.h,
                minWidth: 177.w,
                color: AppColors.yellow,
                padding: EdgeInsets.zero,
                shape:
                    RoundedRectangleBorder(borderRadius: AppBorders.circular10),
                child: controller.isPostingConsultation
                    ? const CupertinoActivityIndicator()
                    : Text(
                        'order'.tr,
                        style: AppTextStyles.size20weight700Black,
                      ),
                onPressed: () {
                  if(controller.isPostingConsultation == false) {
                    controller.postConsultation(context);
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.dialogBackground,
      insetAnimationCurve: Curves.bounceIn,
      shape: RoundedRectangleBorder(borderRadius: AppBorders.circular35),
      child: Container(
        height: 450.h,
        width: 331.w,
        padding: AppSpaces.kTBPadding1725,
        child: Column(
          children: [
            CloseIconButton(onTap: (){}),
            Lottie.asset(
              'assets/lottie/success.json',
              height: 182.h,
              width: 182.w,
              repeat: false,
            ),
            AppSpaces.spaceVertical30,
            Text("thanks".tr, style: AppTextStyles.size40weight700),
            AppSpaces.spaceVertical10,
            Wrap(
              children: [
                Text(
                  "successfully_processed".tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.size18weight400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FailDialog extends StatelessWidget {
  const FailDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.dialogBackground,
      insetAnimationCurve: Curves.bounceIn,
      shape: RoundedRectangleBorder(borderRadius: AppBorders.circular35),
      child: Container(
        height: 400.h,
        width: 331.w,
        padding: AppSpaces.kTBPadding1725,
        child: Column(
          children: [
            CloseIconButton(onTap: (){}),
            Lottie.asset(
              'assets/lottie/fail.json',
              height: 182.h,
              width: 182.w,
              repeat: false,
            ),
            AppSpaces.spaceVertical30,
            Text("error".tr, style: AppTextStyles.size40weight700),
            AppSpaces.spaceVertical10,
            Text(
              "smth_went_wrong".tr,
              textAlign: TextAlign.center,
              style: AppTextStyles.size18weight400,
            ),
          ],
        ),
      ),
    );
  }
}

class OutOfStockDialog extends StatelessWidget {
  const OutOfStockDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.dialogBackground,
      insetAnimationCurve: Curves.bounceIn,
      shape: RoundedRectangleBorder(borderRadius: AppBorders.circular35),
      child: Container(
        height: 400.h,
        width: 331.w,
        padding: AppSpaces.kTBPadding1725,
        child: Column(
          children: [
            CloseIconButton(onTap: (){}),
            Lottie.asset(
              'assets/lottie/no_product_left.json',
              height: 182.h,
              width: 182.w,
            ),
            AppSpaces.spaceVertical30,
            Text("out_of_stock".tr, style: AppTextStyles.size23weight700Black),
            AppSpaces.spaceVertical10,
            Text(
              "not_available".tr,
              textAlign: TextAlign.center,
              style: AppTextStyles.size18weight400,
            ),
          ],
        ),
      ),
    );
  }
}

class WarningDialog extends StatelessWidget {
  const WarningDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      insetAnimationCurve: Curves.easeOutCirc,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r)
      ),
      child: SizedBox(
        height: 173.h,
        width: 257.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/warning.json', fit: BoxFit.contain, height: 80.h, width: 80.w),
            AppSpaces.spaceVertical20,
            Text("warning".tr, style: AppTextStyles.size14weight400,textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
