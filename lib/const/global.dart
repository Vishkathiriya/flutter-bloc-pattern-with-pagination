import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppColor {
  static const Color appColor = Color(0xff0f0fa8);
  static const Color buttonColor = Color(0xffF7AA06);
  static const Color cardColor = Color(0xffC7AA06);
  static const Color containerColor = Color(0xFFFFFFFF);
}

class PrefObj {
  static Box? preferences;
}

// // ===================== LOADER ==================
class Loader {
  void showLoader(BuildContext context) {
    showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xffEE2B7A)),
                  ),
                ),
              )
            ],
          ));
        });
  }

  void hideLoader(BuildContext context) {
    Navigator.pop(context);
  }
}

// ============================ SHOWDIALOG ==============================
void showpopDialog(BuildContext context, String title, String body) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          FlatButton(
            child: const Text('NO'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: const Text('YES'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

enum NetworkStatus { Online, Offline }
