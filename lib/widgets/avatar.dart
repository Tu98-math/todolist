import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({ Key? key, required this.avatarLink, this.sizeAvatr = 30.0, this.padding = 0.0}) : super(key: key);

  final String avatarLink;
  final double sizeAvatr, padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: avatarLink != '' 
        ? CircleAvatar(
          radius: sizeAvatr,
          backgroundImage: NetworkImage(
            '$avatarLink',
          ),
        ) 
        : CircleAvatar(
          radius: sizeAvatr,
          backgroundImage: AssetImage(
            "assets/images/none-avatar.png",
          ),
        )
    );
  }
}