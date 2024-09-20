import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<XFile> compressFile(File file) async {
  final result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    file.absolute.path + '_compressed.jpg',
    quality: 70,
  );
  return result!;
}
