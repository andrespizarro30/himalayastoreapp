import 'package:flutter/material.dart';
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
    return Column(
      children: [
        PagerViewScreen(category: "ACEITES Y MANTEQUILLAS",productName: "Aceite de Ajonjoli x 500 ML"),
        PagerViewScreen(category: "FRUTOS SECOS GRANOS Y DESHIDRATADOS",productName: "Almendra Entera X 125 Grs"),
        PagerViewScreen(category: "ESPECIAS, CONDIMENTOS y AROMATICAS",productName: "Achiote En Grano x 125 Gr "),
        PagerViewScreen(category: " CANNABIS MEDICINAL Y DERIVADOS",productName: " Alcohol Cannabico Green Oil x 120 ML"),
      ],
    );
  }
}
