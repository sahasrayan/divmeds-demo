import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class PostReviewScreen extends StatefulWidget {
  final String caption;
  final List<XFile> images;
  final List<XFile> videos;

  const PostReviewScreen({
    required this.caption,
    required this.images,
    required this.videos,
    super.key,
  });

  @override
  _PostReviewScreenState createState() => _PostReviewScreenState();
}

class _PostReviewScreenState extends State<PostReviewScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  VideoPlayerController? _videoController;
  double _aspectRatio = 4 / 5;
  static const int _captionLimit = 200;

  @override
  void initState() {
    super.initState();
    if (widget.videos.isNotEmpty) {
      _initializeVideo(widget.videos.first.path);
    }
  }

  void _initializeVideo(String videoPath) {
    _videoController = VideoPlayerController.file(File(videoPath))
      ..initialize().then((_) {
        setState(() {});
        _videoController?.play();
        _videoController?.setLooping(true);
      });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void _submitPost() {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop(true);
    }
  }

  Widget _buildMediaContent() {
    List<Widget> mediaWidgets = [];
    for (var image in widget.images) {
      mediaWidgets.add(_buildImageWidget(image));
    }
    for (var video in widget.videos) {
      mediaWidgets.add(_buildVideoWidget(video));
    }
    return PageView(
      controller: _pageController,
      children: mediaWidgets,
    );
  }

  Widget _buildImageWidget(XFile image) {
    if (image.path.isEmpty) {
      return const Center(child: Text('Invalid image file'));
    }
    return InteractiveViewer(
      minScale: 1,
      maxScale: 3,
      child: AspectRatio(
        aspectRatio: _aspectRatio,
        child: Image.file(
          File(image.path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildVideoWidget(XFile video) {
    if (video.path.isEmpty) {
      return const Center(child: Text('Invalid video file'));
    }
    return _videoController?.value.isInitialized ?? false
        ? InteractiveViewer(
            minScale: 1,
            maxScale: 3,
            child: AspectRatio(
              aspectRatio: _aspectRatio,
              child: VideoPlayer(_videoController!),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    final caption = widget.caption.length > _captionLimit
        ? widget.caption.substring(0, _captionLimit) + '...'
        : widget.caption;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _submitPost,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child: widget.images.isNotEmpty || widget.videos.isNotEmpty
                  ? _buildMediaContent()
                  : Center(
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: Text(
                            caption,
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          if (caption.isNotEmpty && (widget.images.isNotEmpty || widget.videos.isNotEmpty))
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                caption,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}


