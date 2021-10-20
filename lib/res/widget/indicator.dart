import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ============================= Use For Show Loader When Api Response  ============================= //

class Indicators {
  // ================= default size is 20 ================//
  Widget indicatorWidget(
      {double size = 20.0, Color? color, bool addWaitText = false}) {
    final Widget indicator = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitThreeBounce(
          color: color ?? Color(0xFF303030),
          size: size,
        ),
        addWaitText ? SizedBox(height: 8.0) : SizedBox(),
        addWaitText
            ? Text(
                'Please Wait',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )
            : SizedBox(),
      ],
    );

    return indicator;
  }
}
