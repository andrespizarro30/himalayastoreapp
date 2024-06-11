import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/products_page_controller.dart';
import 'package:himalayastoreapp/utils/app_colors.dart';
import 'package:himalayastoreapp/widgets/big_text.dart';
import 'package:himalayastoreapp/widgets/pager_widget.dart';

import '../../utils/dimensions.dart';


class ProductsBodyScreen extends StatefulWidget {
  const ProductsBodyScreen({super.key});

  @override
  State<ProductsBodyScreen> createState() => _ProductsBodyScreenState();
}

class _ProductsBodyScreenState extends State<ProductsBodyScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsPageController>(builder: (controller){
      return controller.productsCategoriesList.isNotEmpty ?
          Column(
          children: List.generate(controller.productsCategoriesList.length, (index){
            return PagerViewScreen(product_category: controller.productsCategoriesList[index].productCategory!);
          })
        ):
      Semantics(
        label: "Indicador de carga de información",
        child: Container(
          alignment: Alignment.center,
          height: Dimensions.screenHeight * 0.75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CircularProgressIndicator(backgroundColor: Colors.white,color: AppColors.himalayaBlue,),
              SizedBox(height: Dimensions.height20,),
              Text("Cargando productos, por favor espere...")
            ],
          ),
        ),
      );
    });
  }
}
