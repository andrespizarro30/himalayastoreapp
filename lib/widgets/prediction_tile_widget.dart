import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/select_address_page_controller.dart';
import '../models/places_code_model.dart';
import '../routes/route_helper.dart';
import '../utils/app_colors.dart';


class PredictionTile extends StatelessWidget {

  final Predictions prediction;

  PredictionTile({Key? key, required this.prediction}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    StructuredFormatting structuredFormatting = prediction.structuredFormatting!;

    return TextButton(
      onPressed: () async {
        Get.find<SelectAddressPageController>().getPlaceDetails(prediction.placeId!);
        var close_address_page = await Get.toNamed(RouteHelper.getSelectAddress());
        if(close_address_page == "load_address"){
          Navigator.pop(context,"load_address");
        }
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 10.0,),
            Row(
              children: [
                Icon(Icons.add_location,color: AppColors.himalayaBlue,),
                SizedBox(width: 14.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(structuredFormatting.mainText!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0,color: AppColors.himalayaBlue),),
                      SizedBox(height: 3.0,),
                      Text(structuredFormatting.secondaryText!,
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),)
                    ],
                  ),
                )
              ],
            ),
            SizedBox(width: 10.0,)
          ],
        ),
      ),
    );
  }
}