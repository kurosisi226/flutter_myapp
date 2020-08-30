import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

class ImageFromUrl extends StatelessWidget {
  final String imageUrl;
  const ImageFromUrl({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl == "") {
      return const Icon(Icons.broken_image);
    }
    final isInvaridUrl = imageUrl.startsWith("http");
    if (!isInvaridUrl) {
      return const Icon(Icons.broken_image);
    } else {
      return TransitionToImage(
        image: AdvancedNetworkImage(
          imageUrl,
          useDiskCache: true,
        ),
        placeholder: const Icon(Icons.broken_image),
        fit: BoxFit.cover,
      );
    }
  }
}
