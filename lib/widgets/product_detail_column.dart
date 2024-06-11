import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/products_page_controller.dart';


import '../utils/app_colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';
import 'small_text.dart';

class ColumnProductDetail extends StatelessWidget {

  final String text;
  final int starts;
  final int product_qty_available;
  bool seeComment;
  int productId;


  ColumnProductDetail({
    super.key,
    required this.text,
    required this.starts,
    required this.product_qty_available,
    this.seeComment = false,
    this.productId = 0
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Semantics(label:text,child: BigText(text: text,size: Dimensions.font16 * 1.3,maxLines: 2,)),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(
                children: List.generate(starts, (index) => Semantics(
                  label: "Cantida de estrella de calificación, total ${starts} estrellas",
                  child: Icon(Icons.star,color: AppColors.himalayaBlue, size: 15,)
                )
                )
            ),
            SizedBox(width: 10,),
            SmallText(text: starts.toString()),
            SizedBox(width: 10,),
            seeComment ?
            Semantics(
              label: "Abrir listado de comentarios",
              child: RichText(
                  text: TextSpan(
                      text: "ver ",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=(){
                              Get.find<ProductsPageController>().openCommentContainer();
                              Get.find<ProductsPageController>().getProductRating(productId.toString());
                            },
                            text: "Comentarios",
                            style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.bold,

                            )
                        )
                      ]
                  )
              ),
            ):
            SizedBox(width: 0,height: 0,)
          ],
        ),
        SizedBox(height: Dimensions.height10,),
        product_qty_available <= 0 ?
        Semantics(label: "Señal de producto no disponible", child: BigText(text: "No disponible",color: Colors.redAccent,size: Dimensions.font16,)) :
        SizedBox(height: Dimensions.height20,),
      ],
    );
  }
}
