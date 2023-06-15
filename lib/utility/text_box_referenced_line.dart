import 'package:flutter/material.dart';
import 'package:ink/utility/circular_container.dart';

class TextBoxReferencedLine extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;

  const TextBoxReferencedLine({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: CircularContainer(
        height: 150,
        radius: 10,
        color: const Color.fromARGB(255, 250, 250, 250),
        width: double.infinity,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              _letterBoxReferenceLine(top: 40),
              child,
              _letterBoxReferenceLine(bottom: 40),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _letterBoxReferenceLine({double? top, double? bottom}) {
    return Positioned(
      left: 20,
      right: 20,
      top: top,
      bottom: bottom,
      child: const Divider(
        thickness: 1,
        height: 1,
        color: Colors.black,
      ),
    );
  }
}
