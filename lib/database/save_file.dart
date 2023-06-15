import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

Future<File> saveFile(File image) async {
  final appDir = await syspaths.getApplicationDocumentsDirectory();
  final filename = path.basename(image.path);
  final cpoiedImage = await image.copy('${appDir.path}/$filename');
  return cpoiedImage;
}
