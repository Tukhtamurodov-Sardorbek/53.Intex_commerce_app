import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intex_commerce/core/app_utils/app_spaces.dart';
import 'package:intex_commerce/pages/home_page/home_controller.dart';
import 'package:intex_commerce/pages/home_page/widgets/label_widget.dart';
import 'package:intex_commerce/pages/home_page/widgets/product_card.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          GetBuilder<HomeController>(
            builder: (controller) {
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: controller.categories.length + 1,
                //controller.datumList.length + 1, //productDataList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int superIndex) {
                  return Column(
                    children: [
                      Label(label: superIndex == 0 ? 'season_sale'.tr : controller.getCategoryName(superIndex: superIndex - 1)),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: AppSpaces.kAllPadding30,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: superIndex == 0 || controller.products[superIndex - 1][controller.categories[superIndex - 1].id]!.isEmpty
                            ? 1 : controller.products[superIndex - 1][controller.categories[superIndex - 1].id]!.length,
                        //controller.productDataList.length,//controller.productDataList.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return AppSpaces.spaceVertical30;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return superIndex == 0
                              ? const TextMessage()
                              : controller
                                      .products[superIndex - 1][controller
                                          .categories[superIndex - 1].id]!
                                      .isEmpty
                                  ? AppSpaces.spaceVertical30
                                  : ProductCard(
                                      superIndex: superIndex - 1,
                                      index: index,
                                    );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
