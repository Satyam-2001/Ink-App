import 'package:flutter/material.dart';

class CircularContainer extends Container {
  CircularContainer({
    super.key,
    Widget? child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? radius = 0,
    Color? color,
    double? height,
    double? width,
    Border? border,
    Gradient? gradient,
  }) : super(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: border,
            color: color,
            gradient: gradient,
            borderRadius: BorderRadius.all(
              Radius.circular((radius as num).toDouble()),
            ),
          ),
          padding: padding,
          margin: margin,
          child: child,
          width: width,
          height: height,
        );
}
