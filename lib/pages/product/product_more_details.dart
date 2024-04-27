import 'package:flutter/material.dart';
import 'package:himalayastoreapp/models/products_list_model.dart';
import 'package:himalayastoreapp/utils/app_colors.dart';
import 'package:himalayastoreapp/widgets/big_text.dart';
import 'package:himalayastoreapp/widgets/small_text.dart';

import '../../utils/dimensions.dart';

class ProductMoreDetailsScreen extends StatelessWidget {

  ProductModel product;

  ProductMoreDetailsScreen({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Himalaya"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              product.mainTitle!.isNotEmpty ? BigText(text: product.mainTitle!, maxLines: 2,) : SmallText(text: ""),
              product.productImage2! != "" ?
              Container(
                width: double.maxFinite,
                height: Dimensions.productDetailImgSize/2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            product.productImage2!
                        ),
                        fit: BoxFit.cover
                    )
                ),
              ): SmallText(text: ""),
              product.introductionTitle! != "" ? SmallText(text: product.introductionTitle!,color: AppColors.himalayaGrey) : SmallText(text: ""),
              product.subTitle1! != "" ? BigText(text: product.subTitle1!, maxLines: 2,) : SmallText(text: ""),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  product.paragraph1! != "" ? Expanded(child: SmallText(text: product.paragraph1!,color: AppColors.himalayaGrey,)) : SmallText(text: ""),
                  product.productImage2! != "" ?
                  Container(
                    width: Dimensions.screenWidth/3,
                    height: Dimensions.screenWidth/3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                product.productImage!
                            ),
                            fit: BoxFit.cover
                        )
                    ),
                  ): SmallText(text: ""),
                ],
              ),
              product.subTitle2! != "" ? BigText(text: product.subTitle2!, maxLines: 2,) : SmallText(text: ""),
              product.paragraph2! != "" ? SmallText(text: product.paragraph2!,color: AppColors.himalayaGrey) : SmallText(text: ""),
              product.subTitle3! != "" ? BigText(text: product.subTitle3!, maxLines: 2,) : SmallText(text: ""),
              product.paragraph3! != "" ? SmallText(text: product.paragraph3!,color: AppColors.himalayaGrey) : SmallText(text: ""),
              product.subTitle4! != "" ? BigText(text: product.subTitle4!, maxLines: 2,) : SmallText(text: ""),
              product.paragraph4! != "" ? SmallText(text: product.paragraph4!,color: AppColors.himalayaGrey) : SmallText(text: ""),
              product.subTitle5! != "" ? BigText(text: product.subTitle5!, maxLines: 2,) : SmallText(text: ""),
              product.paragraph5! != "" ? SmallText(text: product.paragraph5!,color: AppColors.himalayaGrey) : SmallText(text: ""),
              product.subTitle6! != "" ? BigText(text: product.subTitle6!, maxLines: 2,) : SmallText(text: ""),
              product.paragraph6! != "" ? SmallText(text: product.paragraph6!,color: AppColors.himalayaGrey) : SmallText(text: ""),
              product.subTitle7! != "" ? BigText(text: product.subTitle7!, maxLines: 2,) : SmallText(text: ""),
              product.paragraph7! != "" ? SmallText(text: product.paragraph7!,color: AppColors.himalayaGrey) : SmallText(text: ""),
              product.subTitle8! != "" ? BigText(text: product.subTitle8!, maxLines: 2,) : SmallText(text: ""),
              product.paragraph8! != "" ? SmallText(text: product.paragraph8!,color: AppColors.himalayaGrey) : SmallText(text: ""),
              product.subTitle9! != "" ? BigText(text: product.subTitle9!, maxLines: 2,) : SmallText(text: ""),
              product.paragraph9! != "" ? SmallText(text: product.paragraph9!,color: AppColors.himalayaGrey) : SmallText(text: ""),
              product.subTitle10! != "" ? BigText(text: product.subTitle10!, maxLines: 2,) : SmallText(text: ""),
              product.paragraph10! != "" ? SmallText(text: product.paragraph10!,color: AppColors.himalayaGrey) : SmallText(text: ""),
              product.subTitle11! != "" ? BigText(text: product.subTitle11!, maxLines: 2,) : SmallText(text: ""),
              product.paragraph11! != "" ? SmallText(text: product.paragraph11!,color: AppColors.himalayaGrey) : SmallText(text: ""),
              product.subTitle12! != "" ? BigText(text: product.subTitle12!, maxLines: 2,) : SmallText(text: ""),
              product.paragraph12! != "" ? SmallText(text: product.paragraph12!,color: AppColors.himalayaGrey) : SmallText(text: ""),
              product.subTitle13! != "" ? BigText(text: product.subTitle13!, maxLines: 2,) : SmallText(text: ""),
              product.paragraph13! != "" ? SmallText(text: product.paragraph13!,color: AppColors.himalayaGrey) : SmallText(text: ""),

            ],
          ),
        ),
      )
    );
  }
}
