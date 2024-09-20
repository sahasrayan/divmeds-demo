import 'package:flutter/material.dart';

class MediaPicker extends StatelessWidget {
  final VoidCallback onPickImage;
  final VoidCallback onPickVideo;

  const MediaPicker({super.key, required this.onPickImage, required this.onPickVideo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: onPickImage,
          icon: const Icon(Icons.image),
          label: const Text('Add Images'),
        ),
        const SizedBox(width: 16.0),
        ElevatedButton.icon(
          onPressed: onPickVideo,
          icon: const Icon(Icons.video_library),
          label: const Text('Add Videos'),
        ),
      ],
    );
  }
}
