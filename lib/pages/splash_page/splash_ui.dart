import 'package:intex_commerce/core/exports/splash_ui.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<SplashController>(builder: (ctr) {
        return Center(
          child: Image.asset(
            'assets/png/local/logo.jpg',
            fit: BoxFit.fitWidth,
          ),
        );
      }),
    );
  }
}
