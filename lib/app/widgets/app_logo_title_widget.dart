import 'package:flutter/material.dart';
import 'package:project428app/app/constants.dart';

class AppLogoTitleWidget extends StatelessWidget {
  const AppLogoTitleWidget({super.key, this.hideTitle});

  final bool? hideTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/lekerlondo_small.png', // Your logo path
          width: kMobileWidth * 0.4, // Adjust size as needed
          fit: BoxFit.contain,
        ),
        hideTitle != null
            ? hideTitle!
                ? SizedBox()
                : Text(
                  kMainTitle,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
            : Text(
              kMainTitle,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
      ],
    );
  }
}
