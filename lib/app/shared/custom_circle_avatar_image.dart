import 'package:flutter/material.dart';

class CustomCircleAvatarImage extends StatelessWidget {
  const CustomCircleAvatarImage({super.key, this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return CircleAvatar(backgroundImage: NetworkImage(url!));
    } else {
      return CircleAvatar(child: Icon(Icons.person));
    }
  }
}
