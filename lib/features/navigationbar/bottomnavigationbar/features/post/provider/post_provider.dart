import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostProvider with ChangeNotifier {
  final TextEditingController captionController = TextEditingController();
  final List<XFile> images = [];
  final List<XFile> videos = [];
  final ImagePicker picker = ImagePicker();
  bool isLoading = false;

  void addImages(List<XFile> newImages) {
    images.addAll(newImages);
    notifyListeners();
  }

  void addVideo(XFile video) {
    videos.add(video);
    notifyListeners();
  }

  void removeImage(XFile image) {
    images.remove(image);
    notifyListeners();
  }

  void removeVideo() {
    videos.clear();
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void clear() {
    captionController.clear();
    images.clear();
    videos.clear();
    isLoading = false;
    notifyListeners();
  }
}
