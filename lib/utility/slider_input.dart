import 'package:flutter/material.dart';
import 'package:ink/utility/circular_container.dart';

class CustomSliderInput extends StatelessWidget {
  const CustomSliderInput({
    super.key,
    required this.title,
    required this.value,
    required this.setValue,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.color,
  });

  final String title;
  final double value;
  final void Function(double value) setValue;
  final double min;
  final double max;
  final int? divisions;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircularContainer(
            width: 120.0,
            radius: 20,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color:
                (color ?? Theme.of(context).colorScheme.primary).withAlpha(60),
            child: Text(title),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Slider(
              activeColor: color,
              inactiveColor: color,
              thumbColor: color,
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              label: value.round().toString(),
              onChanged: setValue,
            ),
          ),
          CircularContainer(
            width: 40.0,
            radius: 5,
            color:
                (color ?? Theme.of(context).colorScheme.primary).withAlpha(60),
            child: Text(
              '${value.round()}',
            ),
          )
        ],
      ),
    );
  }
}
