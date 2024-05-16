import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/dimensions.dart';

class ApplIcon extends StatelessWidget {

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  final String text;

  ApplIcon({
    super.key,
    required this.icon,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.size = 40,
    this.iconSize = 16,
    this.text = "."
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor
      ),
      child: text.isNotEmpty ? Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ) :
      Stack(
        children: [
          Positioned(
            top: Dimensions.height10*1.3,
            right: Dimensions.width10*1.2,
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
          Positioned(
            top: Dimensions.height10/20,
            right: Dimensions.width10/5,
            child: Icon(
              Icons.warning,
              color: Colors.redAccent,
              size: 17,
            )
          ),
          Positioned(
              bottom: Dimensions.height10/20,
              right: Dimensions.width10/5,
              child: Icon(
                Icons.edit,
                color: Colors.redAccent,
                size: 17,
              )
          )
        ],
      ),
    );
  }
}
