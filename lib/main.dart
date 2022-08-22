import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intex_commerce/routes/app_pages.dart';
import 'package:intex_commerce/routes/app_routes.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intex_commerce/bindings/splash_binding.dart';
import 'package:intex_commerce/core/app_utils/app_theme.dart';
import 'package:intex_commerce/core/app_utils/app_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intex_commerce/core/app_utils/scroll_config.dart';
import 'package:intex_commerce/translations/app_translations.dart';
import 'package:intex_commerce/core/app_services/database_service.dart';

bool checkResponsiveness = 0 == 0;

void main() async {
  dotenv.load();
  await StorageService.init();
  WidgetsFlutterBinding.ensureInitialized();

  // * StatusBar & NavigationBar Color
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.main.withOpacity(0.7),
    ),
  );

  // * Orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  if (checkResponsiveness) {
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    );
  } else {
    runApp(
      const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [GestureType.onTap],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, widget) {
          return GetMaterialApp(
            useInheritedMediaQuery: checkResponsiveness,

            title: 'Intex',
            debugShowCheckedModeBanner: false,
            theme: AppThemes.light,
            initialBinding: SplashBindings(),
            initialRoute: AppRoutes.initial,
            getPages: AppPages.pages,

            // * Localization
            locale: checkResponsiveness
                ? DevicePreview.locale(context)
                : AppTranslations.defaultLanguage(context),
            fallbackLocale: const Locale('ru', "RU"),
            translations: AppTranslations(),
            // fallbackLocale: const Locale('ru', "RU"),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate
            ],

            // * To remove the glow on the whole application
            builder: checkResponsiveness
                ? DevicePreview.appBuilder
                : (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                      child: ScrollConfiguration(
                        behavior: NoGlowBehavior(),
                        child: child!,
                      ),
                    );
                  },
          );
        },
      ),
    );
  }
}
