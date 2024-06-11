import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/utils/app_colors.dart';

import '../utils/dimensions.dart';

class ChatBubble extends StatelessWidget {

  String message;
  Color bubbleColor;

  ChatBubble({
    super.key,
    required this.message,
    required this.bubbleColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: bubbleColor
      ),
      child: Semantics(
        label: "Opinión de usuario que califica el producto, ${message}",
        child: Text(
          message,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.mainBlackColor
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
