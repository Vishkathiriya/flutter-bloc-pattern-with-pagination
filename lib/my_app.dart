import 'package:bloc_pattern_demo/const/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import 'res/Home/home_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({required this.prefs});
  final Box prefs;

  @override
  _MyAppState createState() => _MyAppState(prefs: prefs);
}

class _MyAppState extends State<MyApp> {
  _MyAppState({required this.prefs});
  Box prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () {
        return MaterialApp(
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: MediaQuery(
                data: mediaQueryData.copyWith(textScaleFactor: 1.0),
                child: child!,
              ),
            );
          },
          debugShowCheckedModeBanner: false,
          // ============================= Use For Set Theme of App Like Font and Font Color  ============================= //
          theme: ThemeData(
            primaryColor: AppColor.appColor,
            appBarTheme: Theme.of(context)
                .appBarTheme
                .copyWith(brightness: Brightness.light),
            fontFamily: 'popin',
            textTheme: Theme.of(context).textTheme.apply(fontFamily: 'popin'),
          ),
          home: _dicedeScreen(prefs),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

// ===================== HOME SCREEN ==================
Widget _dicedeScreen(Box prefs) {
  PrefObj.preferences = prefs;
  return HomeScreen();
}
