import 'package:device_preview/device_preview.dart';
import 'package:intex_commerce/core/exports/main.dart';

bool checkResponsiveness = 0 != 0;

class EntryPoint{
  static entryPoint() async{
    dotenv.load();
    // await StorageService.init();
    await Hive.initFlutter();
    await Hive.openBox(DatabaseService.DB_NAME);
    WidgetsFlutterBinding.ensureInitialized();

    // * StatusBar Color
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
          builder: (context) => const Main(),
        ),
      );
    } else {
      runApp(
        const Main(),
      );
    }
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

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
            fallbackLocale: const Locale('ru'),
            translations: AppTranslations(),
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
