import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/util/utils/route_util.dart';
import 'package:lechoix/features/auth/presentation/pages/login_screen.dart';
import 'package:lechoix/features/splash/presentation/pages/onboarding_screen.dart';
import 'package:lechoix/features/splash/presentation/pages/splash_screen.dart';
import 'cache/user_cache.dart';



const isProductionMood = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final HttpLink httpLink = HttpLink("https://test.lechoix.com/graphql");
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );
  // await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await UserCache.instance.init();
  // await NotificationHandler.instance.init();
  var app = GraphQLProvider(
      client: client,
      child: EasyLocalization(
          supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MyApp()))
  runApp(app);
  // runApp(
  //   EasyLocalization(
  //     supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
  //     path: 'assets/translations',
  //     fallbackLocale: const Locale('en', 'US'),
  //     child: const MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationUtil.navigatorKey,
      title: "lechoix",
      builder: BotToastInit(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        fontFamily:"Almarai",
        primarySwatch: UIConstants.primaryMaterialColor,
        scaffoldBackgroundColor: UIConstants.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: UIConstants.primaryMaterialColor,
          // primaryVariant: UIConstants.primaryMaterialColor,
          onPrimary: UIConstants.secondaryColor,
          onSecondary: UIConstants.primaryMaterialColor,
          secondary: UIConstants.secondaryColor,
          // secondaryVariant: UIConstants.secondaryColor,
          error: Colors.red,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return UIConstants.gray5Color;
                }
                return null;
              },
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return UIConstants.primaryMaterialColor;
                }
                return null;
              },
            ),
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: UIConstants.secondaryColor,
        ),
        dividerTheme: const DividerThemeData(
          color: UIConstants.gray6Color,
          thickness: 1.0,
        ),
        checkboxTheme: CheckboxThemeData(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: const BorderSide(color: UIConstants.gray4Color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.radius),
          ),
        ),
        typography: Typography.material2018(),
        visualDensity: VisualDensity.compact,
      ),
      darkTheme: ThemeData(
        fontFamily:"Almarai",
        brightness: Brightness.dark,
        primarySwatch: UIConstants.primaryMaterialColor,
        primaryColor: UIConstants.primaryMaterialColor,
        indicatorColor: UIConstants.primaryMaterialColor,
        colorScheme: const ColorScheme.dark(
          primary: UIConstants.primaryMaterialColor,
          // primaryVariant: UIConstants.primaryMaterialColor,
          onPrimary: Colors.white,
          secondary: UIConstants.primaryMaterialColor,
          // secondaryVariant: UIConstants.primaryMaterialColor,
        ),
        typography: Typography.material2018(),
        visualDensity: VisualDensity.compact,
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return UIConstants.primaryMaterialColor;
            }
            return null;
          }),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return UIConstants.primaryMaterialColor;
            }
            return null;
          }),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return UIConstants.primaryMaterialColor;
            }
            return null;
          }),
          trackColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return UIConstants.primaryMaterialColor;
            }
            return null;
          }),
        ),
      ),
      initialRoute: RouteUtil.splashRoute,
      routes: {
        RouteUtil.splashRoute: (context) => const SplashScreen(),
        RouteUtil.onboardingRoute: (context) => const OnboardingScreen(),
        RouteUtil.login: (context) => const LoginScreen(),
        // RouteUtil.hostRoute: (context) => HostScreen(
        //       key: HostScreen.hostPageKey,
        //     ),
      },
    );
  }
}
