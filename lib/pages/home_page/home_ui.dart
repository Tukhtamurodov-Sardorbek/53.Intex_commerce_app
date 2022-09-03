import 'package:intex_commerce/core/exports/home_ui.dart';

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
