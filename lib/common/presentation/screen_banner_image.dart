import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class ScreenBannerImage extends HookConsumerWidget
    with UiLoggy {
  const ScreenBannerImage({
    required this.imagePath,
    this.height = double.infinity,
    this.width = double.infinity,
    this.isNetwork = false,
    super.key,
  });

  final double height;
  final double width;
  final String imagePath;
  final bool isNetwork;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const fit = BoxFit.cover;
    return SizedBox(
      height: height,
      width: width,
      child: isNetwork
          ? CachedNetworkImage(
              imageUrl: imagePath,
              fit: fit,
            )
          : Image.asset(imagePath, fit: fit),
    );
  }
}
