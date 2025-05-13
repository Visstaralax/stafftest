import 'package:flutter/material.dart';

class ImageLoader extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;

  const ImageLoader({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  State createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  late Image _image;
  late bool _isLoading;
  late bool _hasError;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasError = false;
    _loadImage();
  }

  void _loadImage() {
    _image = Image.network(widget.imageUrl);
    _image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
            (info, call) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _hasError = false;
            });
          }
        },
        onError: (exception, stackTrace) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (_hasError) {
      return Center(
        child: Icon(Icons.error, color: Colors.red),
      );
    } else {
      return Image(
        image: _image.image,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
      );
    }
  }
}
