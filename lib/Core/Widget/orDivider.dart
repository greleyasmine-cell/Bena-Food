import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget orDivider(){
  return Row(
    children: [
      Expanded(child: Divider(color: AppColors.white,thickness: 1,)),
      Padding(padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text("Or",style: TextStyle(color: AppColors.secondary,fontSize: 13),),
      ),
      Expanded(child: Divider(color: AppColors.white,thickness: 1,)),
    ],
  );
}