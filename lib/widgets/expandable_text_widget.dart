
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:himalayastoreapp/widgets/small_text.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';

class ExpandableText extends StatefulWidget {

  final String text;

  const ExpandableText({
    super.key,
    required this.text
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {

  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight/5.63;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }

  }

  @override
  Widget build(BuildContext context) {

    String inkWellText = hiddenText ? "Show more" : "Show less";

    return Semantics(
      label: "Descripcion del producto, ${widget.text}",
      child: Container(
        child: secondHalf.isEmpty ? SmallText(text: firstHalf,size: Dimensions.font16,color: AppColors.paraColor) : Column(
          children: [
            SmallText(text: hiddenText ? (firstHalf + "..."):(firstHalf+secondHalf),
              size: Dimensions.font16,
              color: AppColors.paraColor,
              height: 1.8,
            ),
            InkWell(
              onTap: (){
                setState(() {
                  hiddenText = hiddenText ? false : true;
                });
              },
              child: Row(
                children: [
                  SmallText(text: inkWellText,color: AppColors.himalayaBlue,size: Dimensions.font16,),
                  Icon(hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,color: AppColors.himalayaBlue)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
