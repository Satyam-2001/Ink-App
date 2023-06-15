import 'package:flutter/material.dart';
import 'package:ink/utility/circular_container.dart';

class GradientCircularContainer extends InkWell {
  GradientCircularContainer({
    super.key,
    Widget? child,
    EdgeInsets? padding,
    double? radius,
    Color? color,
    double? height,
    double? width,
    Gradient? gradient,
    IconData? icon,
    String? title,
    void Function()? onTap,
  }) : super(
          onTap: onTap,
          child: Card(
              elevation: 4,
              child: CircularContainer(
                border:
                    color != null ? Border.all(color: color, width: 2) : null,
                gradient: LinearGradient(
                  colors: [
                    (color as Color).withAlpha(80),
                    color.withAlpha(120),
                    color.withAlpha(160),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                radius: radius,
                padding: padding,
                width: width,
                height: height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon),
                    const SizedBox(width: 8),
                    Text(
                      title ?? '',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              )),
        );
}
