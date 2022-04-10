import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.avatarLink,
    this.sizeAvatar = 30.0,
  }) : super(key: key);

  final String? avatarLink;
  final double sizeAvatar;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizeAvatar,
      height: sizeAvatar,
      child: avatarLink != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(
                '$avatarLink',
              ),
            )
          : CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/none-avatar.png",
              ),
            ),
    );
  }
}
