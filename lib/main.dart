import 'dart:io';
import 'package:bloc_pattern_demo/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  // ============================= Use For Store Data In Local  ============================= //
  await Hive.openBox('bloc_demo').then(
    (value) => runApp(
      MyApp(prefs: value),
    ),
  );
}
