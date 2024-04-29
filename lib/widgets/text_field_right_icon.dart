import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';


class TextFieldRightIcon extends StatelessWidget {

  final TextEditingController textEditingController;
  final String textHint;
  final IconData icon;
  final TextInputType textInputType;
  final bool isPassword;
  final bool isEnabled;
  final int maxLines;

  TextFieldRightIcon({
    super.key,
    required this.textEditingController,
    required this.textHint,
    required this.icon,
    required this.textInputType,
    this.isPassword = false,
    this.isEnabled = true,
    this.maxLines = 1
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.width10/10,right: Dimensions.width10/10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          boxShadow: [
            BoxShadow(
                blurRadius: Dimensions.radius20/2,
                spreadRadius: Dimensions.radius15/2,
                offset: Offset(1,1),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        enabled: isEnabled,
        keyboardType: textInputType,
        controller: textEditingController,
        obscureText: isPassword,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: textHint,
          suffixIcon: GestureDetector(
            onTap: (){
              textEditingController.text = "";
            },
            child: Icon(icon, color: AppColors.himalayaBlue,)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular((Dimensions.radius15)),
            borderSide: BorderSide(
                width: 1.0,
                color: Colors.transparent
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular((Dimensions.radius15)),
            borderSide: BorderSide(
                width: 1.0,
                color: Colors.transparent
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular((Dimensions.radius15)),
            borderSide: BorderSide(
                width: 1.0,
                color: Colors.transparent
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular((Dimensions.radius15)),
            borderSide: BorderSide(
                width: 1.0,
                color: Colors.transparent
            ),
          ),
        ),
      ),
    );
  }
}
