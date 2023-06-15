import 'package:flutter/material.dart';
import 'package:ink/models/letter_image.dart';
import 'package:ink/utility/circular_container.dart';

class LettersImageBlock extends StatelessWidget {
  const LettersImageBlock({
    super.key,
    required this.letterImage,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
    this.size,
    this.margin,
    this.padding,
  });

  final LetterImage letterImage;
  final bool isSelected;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final double? size;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: CircularContainer(
        width: size,
        height: size,
        padding: padding,
        margin: margin,
        radius: 5,
        color: Theme.of(context).colorScheme.onBackground.withAlpha(20),
        child: Stack(
          children: [
            Center(child: Image.file(letterImage.file)),
            if (isSelected)
              Container(
                color: Theme.of(context).colorScheme.onBackground.withAlpha(60),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 40,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
