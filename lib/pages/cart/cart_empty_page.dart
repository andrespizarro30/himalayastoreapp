import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {

  final String text;
  final String imgPath;

  const NoDataPage({super.key,
    required this.text,
    this.imgPath = "assets/images/empty_cart.png"
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            imgPath,
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Text(
            text,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height*0.0175,
                color: Theme.of(context).disabledColor
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
