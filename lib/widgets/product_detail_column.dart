import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../utils/app_colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';
import 'small_text.dart';

class ColumnProductDetail extends StatelessWidget {

  final String text;
  final int starts;

  const ColumnProductDetail({
    super.key,
    required this.text,
    required this.starts
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font16 * 1.3,maxLines: 2,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(
                children: List.generate(starts, (index) => Icon(Icons.star,color: AppColors.himalayaBlue, size: 15,))
            ),
            SizedBox(width: 10,),
            SmallText(text: starts.toString()),
            SizedBox(width: 10,),
            SmallText(text: "888"),
            SizedBox(width: 10),
            SmallText(text: "comments")
          ],
        ),
        SizedBox(height: Dimensions.height20,),
      ],
    );
  }
}
