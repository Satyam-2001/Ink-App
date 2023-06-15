import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PageInfo {
  PageInfo({
    required this.image,
    required this.xpos,
    required this.ypos,
    required this.lineHeight,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final File image;
  final int xpos;
  final int ypos;
  final int lineHeight;
}
