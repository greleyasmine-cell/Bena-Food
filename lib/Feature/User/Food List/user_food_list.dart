import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/userWidget/food_item_card.dart';
import 'package:bena_food/Feature/User/Food%20List/manager/user_food_cubit.dart';
import 'package:bena_food/Feature/User/Food%20List/manager/user_food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFoodList extends StatelessWidget {
  final String restaurantId;
  final String restaurantName;
  final VoidCallback onBack;
  final Function(Map<String, dynamic>) onFoodTap;
  const UserFoodList({super.key,
  required this.restaurantId,
    required this.restaurantName,
    required this.onBack,
    required this.onFoodTap
  });

  @override
  Widget build(BuildContext context) {
    context.read<UserFoodCubit>().getRestaurantFoods(restaurantId);
    return SafeArea(child: Column(

      children: [
        Padding(padding: EdgeInsets.all(20),
        child: Row(
          children: [
            IconButton(icon:Icon(Icons.arrow_back),onPressed: onBack,),

            Expanded(child: Center(child: Text(restaurantName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.primary),),)),
          ],
        ),
        ),


        Expanded(child: BlocBuilder<UserFoodCubit,UserFoodState>(
            builder: (context,state) {
              if(state.status == UserFoodStatus.loading){
                return Center(child: CircularProgressIndicator(color: AppColors.primary,),);
              }
              if(state.foods.isEmpty){
                return Center(child: Text("No meals available",style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.bold,fontSize: 22),),);
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: state.foods.length,
                itemBuilder:(context, index){
                  final food = state.foods[index];
                  return FoodItemCard(food: food,
                  onTap: () => onFoodTap(food),
                  );
                },);
            }))
      ],
    ));
  }
}
