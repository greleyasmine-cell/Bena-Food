import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/adminWidget/action_button.dart';
import 'package:bena_food/Feature/Admin/Add%20Restaurant/manager/add_restaurant_cubit.dart';
import 'package:bena_food/Feature/Admin/edit_restaurant_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget AdminRestaurantCard(BuildContext context, Map<String,dynamic> data,Function(Map<String,dynamic>) onEdit,Function(Map<String,dynamic>) onView){
  final String name = (data['name'] ?? "Restaurant Name").toString();
  final String status = (data['status'] ?? "Close").toString();
  final String image = (data['image'] ?? "").toString();
  final String id = (data['id'] ?? "").toString();

  return Container(
    margin:  EdgeInsets.symmetric(horizontal: 12,vertical: 8),
    height: 140,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(color: AppColors.primary,width: 2),
    ),
    child: Row(
      children: [
        Container(
          width: 130,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(23),
              bottomLeft: Radius.circular(23),
            ),
          ),
          child: Center(
            child: image.isNotEmpty
            ?Image.network(
              image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            )
                :Container(
              height: 100,
              width: 100,
              color: AppColors.primary,
              child: Icon(Icons.restaurant,color: AppColors.white,size: 40,),
            ),
          ),
        ),
        Expanded(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text("Status:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                    Text(status,
                    style: TextStyle(
                      color: status == "Open" ? Colors.green : Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    )
                  ],
                ),
                SizedBox(height: 15,),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      ActionButton(
                          label: "Edit",
                          icon: Icons.edit,
                          onTap:() {
                            onEdit(data);
                          },
                          color: AppColors.primary
                      ),
                      SizedBox(width: 8,),
                      ActionButton(
                          label: "Delete",
                          icon: Icons.delete,
                          onTap: (){
                            if(id.isNotEmpty){
                              context.read<AddRestaurantCubit>().deleteRestaurant(id);
                            }
                          },
                          color: AppColors.primary
                      ),
                      SizedBox(width: 8,),
                      ActionButton(
                          label: "View",
                          icon: Icons.visibility,
                          onTap: () => onView(data),
                          color: AppColors.primary),
                    ],
                  ),
                )
              ],
            ),
        ))
      ],
    ),
  );
}