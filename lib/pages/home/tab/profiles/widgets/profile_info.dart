import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '/constants/app_colors.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
    required this.user,
    required this.press,
    required this.createTask,
    required this.completedTask,
  }) : super(key: key);

  final User user;

  final int createTask, completedTask;

  final Function press;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://kenh14cdn.com/thumb_w/660/203336854389633024/2021/9/3/photo-1-1630605138626798987164.jpg',
              imageBuilder: (context, imageProvider) => Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ).pad(23, 10, 24),
              placeholder: (context, url) => Shimmer(
                child: Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ).pad(23, 10, 24),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  user.displayName
                      .toString()
                      .plain()
                      .fSize(18)
                      .lHeight(21.09)
                      .color(AppColors.kText)
                      .weight(FontWeight.w600)
                      .lines(1)
                      .overflow(TextOverflow.ellipsis)
                      .b(),
                  user.email
                      .toString()
                      .plain()
                      .fSize(16)
                      .lHeight(19.7)
                      .color(AppColors.kGrayTextB)
                      .lines(1)
                      .overflow(TextOverflow.ellipsis)
                      .b(),
                ],
              ).pad(0, 0, 35),
            ),
            Icon(Icons.settings).pad(10).inkTap(
                  onTap: press,
                  borderRadius: BorderRadius.circular(100),
                ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 120.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  '$createTask'
                      .plain()
                      .fSize(18)
                      .lHeight(21.09)
                      .color(AppColors.kText)
                      .weight(FontWeight.w300)
                      .b(),
                  'Create Tasks'
                      .plain()
                      .fSize(16)
                      .lHeight(19.7)
                      .color(AppColors.kGrayTextA)
                      .b(),
                ],
              ),
            ),
            Container(
              width: 160.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  '$completedTask'
                      .plain()
                      .fSize(18)
                      .lHeight(21.09)
                      .color(AppColors.kText)
                      .weight(FontWeight.w300)
                      .b(),
                  'Completed Tasks'
                      .plain()
                      .fSize(16)
                      .lHeight(19.7)
                      .color(AppColors.kGrayTextA)
                      .b(),
                ],
              ),
            ),
          ],
        ).pad(27, 27, 0, 29),
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.imageUrl,
    this.size = 64,
  }) : super(key: key);

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: size.w,
        height: size.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ).pad(23, 10, 24),
      placeholder: (context, url) => Shimmer(
        child: Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ).pad(23, 10, 24),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
