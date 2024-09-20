import 'dart:io';
import 'package:divmeds/core/api/api.url.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:divmeds/features/auth/repositories/user_repo.dart';
import 'package:divmeds/utils/image_compressor.dart';

class EditProfilePicture extends StatefulWidget {
  final Function(String) onUpdateProfilePicture;
  final UserRepository userRepository;
  final String token;

  const EditProfilePicture({
    required this.onUpdateProfilePicture,
    required this.userRepository,
    required this.token,
    super.key,
  });

  @override
  _EditProfilePictureState createState() => _EditProfilePictureState();
}

class _EditProfilePictureState extends State<EditProfilePicture> {
  XFile? _selectedImage;
  CroppedFile? _croppedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.camera,
      Permission.photos,
      Permission.storage,
    ].request();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
      await _cropImage(image.path);
    }
  }

  Future<void> _cropImage(String imagePath) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 70,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Colors.blue,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    if (croppedImage != null) {
      setState(() {
        _croppedImage = croppedImage;
      });
    }
  }

  Future<void> _uploadProfilePicture() async {
    if (_croppedImage != null) {
      setState(() {
        _isLoading = true;
      });

      final file = File(_croppedImage!.path);
      final compressedFile = await compressFile(file);

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(compressedFile.path, filename: compressedFile.path.split('/').last),
      });

      try {
        await widget.userRepository.updateProfilePicture(formData, widget.token);
        final imageUrl = '${Config.serverUrl}uploads/${compressedFile.path.split('/').last}';
        widget.onUpdateProfilePicture(imageUrl);
        Navigator.of(context).pop();
      } catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile picture')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Picture'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_selectedImage != null)
                    _croppedImage != null
                        ? Image.file(File(_croppedImage!.path))
                        : Image.file(File(_selectedImage!.path)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text('Choose Image'),
                      ),
                      ElevatedButton(
                        onPressed: _croppedImage != null ? _uploadProfilePicture : null,
                        child: Text('Save'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
