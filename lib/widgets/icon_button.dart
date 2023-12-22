import 'package:flutter/material.dart';

import '../utils/color_constants.dart';

class IconButtonWidget extends StatelessWidget {
  final String image;
  const IconButtonWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 6,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: ColorConstants.lightRed,
          side: const BorderSide(color: ColorConstants.red, width: 1),
          minimumSize: const Size(55, 55),
          shape: const CircleBorder(side: BorderSide(style: BorderStyle.solid)),
        ),
        onPressed: () {},
        child: Image.asset(
          image,
        ),
      ),
    );
  }
}
