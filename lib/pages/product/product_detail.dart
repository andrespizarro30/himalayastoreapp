import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/widgets/product_detail_column.dart';

import '../../routes/route_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';

class ProductDetailScreen extends StatelessWidget {

  int pageId;
  String page;

  ProductDetailScreen({
    super.key,
    required this.pageId,
    required this.page
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.productDetailImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/kapitaltaskmanager.appspot.com/o/delivery_app%2Fimagen1.jpg?alt=media&token=09662d0d-5c80-4711-96b8-6887400f3569"
                        ),
                        fit: BoxFit.cover
                    )
                ),
              )
          ),
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: ApplIcon(icon: Icons.clear),
                    onTap: (){
                      if(page=='cartPage'){
                        //Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getHome());
                      }
                    },
                  ),
                  ApplIcon(icon: Icons.shopping_cart_outlined)
                ],
              )
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.productDetailImgSize-Dimensions.height20,
              child: Container(
                  padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius20),
                          topLeft: Radius.circular(Dimensions.radius20)
                      ),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ColumnProductDetail(text: "ABCD-1234",),
                      SizedBox(height: Dimensions.height20,),
                      BigText(text: "Introduce"),
                      SizedBox(height: Dimensions.height20,),
                      Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableText(text: "La sal del Himalaya es un tesoro natural que se forma en las profundidades de las montañas del Himalaya, una de las cadenas montañosas más majestuosas y remotas del mundo. Esta sal se ha convertido en un producto muy apreciado por su pureza y sus presuntas propiedades saludables."
                                "Su característico color rosado se debe a la gran cantidad de minerales presentes en ella, especialmente hierro. Estos minerales no solo le otorgan su distintivo color, sino que también se cree que aportan beneficios para la salud, como la regulación del equilibrio de electrolitos en el cuerpo, la mejora de la circulación sanguínea y la promoción de la hidratación celular."
                                "La sal del Himalaya se extrae de antiguas minas subterráneas que se formaron hace millones de años, protegidas de la contaminación moderna y preservadas en un ambiente puro y prístino. Su proceso de extracción es tradicional y manual, lo que garantiza su pureza y calidad."
                                "Además de su uso culinario como condimento, la sal del Himalaya también se utiliza en terapias de spa y tratamientos de bienestar, como baños de sal y lámparas de sal, que se dice que ayudan a purificar el aire y a crear un ambiente más saludable en el hogar."
                                "En resumen, la sal del Himalaya no es solo un condimento exquisito, sino también un símbolo de pureza y bienestar, que nos conecta con la majestuosidad y la antigüedad de las montañas más altas de la Tierra.")
                        ),
                      )
                    ],
                  )
              )
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
        decoration: BoxDecoration(
            color: AppColors.buttonBackGroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20*2),
              topLeft: Radius.circular(Dimensions.radius20*2),
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.width20,left: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white
              ),
              child: Row(
                children: [
                  GestureDetector(
                      onTap:(){
                        //popularProduct.setQuantity(false);
                      },
                      child: Icon(Icons.remove,color: AppColors.signColor,)
                  ),
                  SizedBox(width: Dimensions.width10/2,),
                  BigText(text: '',
                      //text: popularProduct.inCartItems.toString()
                  ),
                  SizedBox(width: Dimensions.width10/2,),
                  GestureDetector(
                      onTap: (){
                        //popularProduct.setQuantity(true);
                      },
                      child: Icon(Icons.add,color: AppColors.signColor,)
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                //popularProduct.addItem(product);
              },
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.width20,left: Dimensions.width20),
                child: BigText(text: "\$ 39900 | Add to cart", color: Colors.white,),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.himalayaBlue
                ),
              ),
            )
          ],
        ),
      )
    );

  }

}
