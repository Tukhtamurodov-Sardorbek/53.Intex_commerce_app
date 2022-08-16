import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:intex_commerce/core/app_utils/app_spaces.dart';
import 'package:intex_commerce/core/app_utils/box_shadow.dart';
import 'package:intex_commerce/core/app_utils/app_borders.dart';
import 'package:intex_commerce/core/app_utils/app_text_styles.dart';
import 'package:intex_commerce/pages/home_page/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intex_commerce/pages/home_page/widgets/dialog_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends GetView<HomeController> {
  final int superIndex;
  final int index;
  const ProductCard({Key? key, required this.superIndex, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctr) {
      return Container(
        height: 225.h,
        width: 260.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppBorders.circularTrBlBr35,
          boxShadow: [
            appBoxShadowCard()
            //ctr.displayShadow ? AppBoxShadowCard() : const BoxShadow(),
          ],
        ),
        child: CachedNetworkImage(
          imageUrl: controller.products[superIndex][controller.categories[superIndex].id]![index].image,
          fit: BoxFit.cover,
          imageBuilder: (BuildContext context, ImageProvider imageProvider){
            return ProductCardUi(
                index: index,
                superIndex: superIndex,
                categoryId: controller.categories[superIndex].id,
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
            return ProductCardUi(
              superIndex: superIndex,
              index: index,
              categoryId: controller.categories[superIndex].id,
              child: Center(
                child: Image.asset('assets/png/icons/ic_no_image.png'),
              ),
            );
          },
        ),
      );
    });
  }
}

class ProductCardUi extends StatelessWidget {
  final int superIndex;
  final int index;
  final int categoryId;
  final Widget child;
  const ProductCardUi({Key? key, required this.child, required this.index, required this.superIndex, required this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Column(
          children: [
            controller
                    .getStatus(
                        superIndex: superIndex,
                        index: index,
                        categoryId: categoryId)
                    .isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 26.h,
                        width: 107.w,
                        decoration: BoxDecoration(
                            color: controller.getStatusColor(
                                superIndex: superIndex,
                                index: index,
                                categoryId: categoryId),
                            borderRadius: AppBorders.circularBr10,
                            boxShadow: [appBoxShadowCardStatus()]),
                        child: Center(
                          child: Text(
                              controller.getStatus(
                                  superIndex: superIndex,
                                  index: index,
                                  categoryId: categoryId),
                              style: AppTextStyles.size13weight700),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            AppSpaces.spaceVertical12,
            Center(
              child: Text(
                controller.getProductCategoryName(superIndex: superIndex, index: index, categoryId: categoryId),
                style: AppTextStyles.productTitle,
              ),
            ),
            AppSpaces.spaceVertical12,
            Expanded(
              child: Padding(
                padding: AppSpaces.kHorizontalPadding46,
                child: Center(
                  child: child,
                ),
              ),
            ),
            AppSpaces.spaceVertical12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Text(
                          '${controller.price(controller.products[superIndex][categoryId]![index].price)} ${'currency'.tr}',
                          style: AppTextStyles.size14weight400,
                        ),
                        Positioned.fill(
                          child: Image.asset(
                            'assets/png/icons/line.png',
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${controller.price(controller.products[superIndex][categoryId]![index].salePrice)} ${'currency'.tr}',
                      style: AppTextStyles.size18weight700,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    controller.openDialog(
                      context: context,
                      child: OrderDialog(
                        id: controller.products[superIndex][categoryId]![index].id,
                        title: controller.getProductName(superIndex: superIndex, categoryId: categoryId, index: index),
                        image: controller.products[superIndex][categoryId]![index].image,
                        price: '${controller.price(controller.products[superIndex][categoryId]![index].salePrice)} ${'currency'.tr}',
                      ),
                    );
                  },
                  child: Container(
                    height: 28.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: AppBorders.circularBlTr10,
                        boxShadow: [appBoxShadowCardOrder()]),
                    child: Center(
                      child: Text(
                        'order'.tr,
                        style: AppTextStyles.size12weight700Black,
                      ),
                    ),
                  ),
                )
              ],
            ),
            AppSpaces.spaceVertical24,
          ],
        );
      }
    );
  }
}