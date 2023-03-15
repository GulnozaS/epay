import 'package:epay/presentation/route.gr.dart';
import 'package:epay/presentation/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../application/local_store.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();

  // ignore: library_private_types_in_public_api
  static _AppWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppWidgetState>();
}

class _AppWidgetState extends State<AppWidget> {
  final appRouter = AppRouter();

  bool isChangeTheme = true;

  void change() {
    isChangeTheme = !isChangeTheme;
    setState(() {});
  }

  @override
  void initState() {
    getTheme();
    super.initState();
  }

  getTheme() async {
    isChangeTheme = await LocalStore.getTheme();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
            themeMode: isChangeTheme ? ThemeMode.light : ThemeMode.dark,
            theme: ThemeData(
                scaffoldBackgroundColor: Style.whiteColor,
                textTheme: TextTheme(
                    headline1: Style.textStyleRegular(),
                    headline2: Style.textStyleRegular(size: 24),
                    headline3: Style.textStyleThin(
                        size: 14, textColor: Style.blackColor)),
                inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Style.blackColor,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Style.blackColor,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Style.blackColor,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Style.blackColor,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    hintStyle: Style.textStyleThin(
                        size: 14, textColor: Style.greyColor))),
            darkTheme: ThemeData(
                scaffoldBackgroundColor: Style.blackColor,
                textTheme: TextTheme(
                    headline1:
                        Style.textStyleRegular(textColor: Style.whiteColor),
                    headline2: Style.textStyleRegular(
                        size: 24, textColor: Style.whiteColor),
                    headline3: Style.textStyleThin(
                        size: 14, textColor: Style.whiteColor)),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Style.blackColor,
                  selectedIconTheme:
                      const IconThemeData(color: Style.primaryBlue),
                  unselectedIconTheme:
                      const IconThemeData(color: Style.whiteColor),
                  unselectedLabelStyle:
                      Style.textStyleRegular(textColor: Style.whiteColor),
                ),
                inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Style.whiteColor,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Style.whiteColor,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Style.whiteColor,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Style.whiteColor,
                        ),
                        borderRadius: BorderRadius.circular(20)),

                    hintStyle: Style.textStyleThin(
                        size: 14, textColor: Style.greyColor))),
            debugShowCheckedModeBanner: false,
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser());
      },
    );
  }
}
