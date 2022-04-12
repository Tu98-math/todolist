import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/constants/images.dart';
import '/util/ui/place_holder/default_shimmer.dart';

class CustomLoadingImage extends StatelessWidget {
  const CustomLoadingImage({
    Key? key,
    required this.width,
    this.height,
    required this.imageUrl,
    this.borderRadius = 2,
    this.border,
  }) : super(key: key);

  final double width, borderRadius;
  final double? height;
  final String imageUrl;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(border: border),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: AspectRatio(
          aspectRatio: (height == null) ? 1 : (width / height!),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => RectangleShimmer(
              width: width,
              height: height ?? width,
            ),
            errorWidget: (context, url, _) => Image.asset(
              AppImages.imgErrorLoadImage,
              width: width,
              height: height ?? width,
            ),
          ),
        ),
      ),
    );
  }
}
