import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:intex_commerce/core/app_utils/app_text_styles.dart';
import 'package:intex_commerce/pages/home_page/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intex_commerce/pages/home_page/widgets/icon_widgets.dart';
import 'package:intex_commerce/pages/home_page/widgets/drawer_widget.dart';
import 'package:intex_commerce/pages/home_page/widgets/footer_widget.dart';
import 'package:intex_commerce/pages/home_page/widgets/sliver_widget.dart';
import 'package:intex_commerce/pages/home_page/widgets/products_list.dart';
import 'package:intex_commerce/pages/home_page/widgets/sliver_app_bar.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctr) {
        return WillPopScope(
          onWillPop: controller.doubleTapToClose,
          child: Scaffold(
            key: scaffoldKey,
            drawer: const SafeArea(child: DrawerWidget()),
            //LiquidPullToRefresh
            body: RefreshIndicator(
              onRefresh: controller.handleRefresh,
              displacement: 100.0,
              // height: 300.h,
              // animSpeedFactor: 2,
              color: AppColors.main,
              // showChildOpacityTransition: true,
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                controller: controller.scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    floating: false,
                    centerTitle: false,
                    expandedHeight: 356.h,
                    backgroundColor: AppColors.main,
                    automaticallyImplyLeading: false,
                    title: FittedBox(
                      child: Text(
                        'INTEX-MARKET.UZ',
                        style: AppTextStyles.size20weight600,
                      ),
                    ),
                    actions: const [
                      AppBarActions(),
                    ],
                    flexibleSpace: const FlexibleSpaceBar(
                      background: SliverAppBarBackground(),
                    ),
                  ),
                  const ProductsList(),
                  SliverWidget(),
                  const Footer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
