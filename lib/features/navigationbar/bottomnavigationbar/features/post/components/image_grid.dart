import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageGrid extends StatelessWidget {
  final List<XFile> images;
  final Function(XFile) onRemove;

  const ImageGrid({super.key, required this.images, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: images.map((image) {
        return Stack(
          children: [
            Image.file(
              File(image.path),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => onRemove(image),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
