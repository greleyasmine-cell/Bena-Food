import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/adminWidget/food_card.dart';
import 'package:bena_food/Core/Widget/adminWidget/manage_btn.dart';
import 'package:bena_food/Feature/Admin/Manage%20Foods/manage/food_cubit.dart';
import 'package:bena_food/Feature/Admin/Manage%20Foods/manage/food_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodList extends StatelessWidget {
  final String restaurantId;
  final String restaurantName;
  final VoidCallback onBack;
  final VoidCallback onAddFood;
  final Function(Map<String, dynamic>) onEditFood;

  const FoodList({
    super.key,
    required this.restaurantId,
    required this.restaurantName,
    required this.onBack,
    required this.onAddFood,
    required this.onEditFood,
  });

  @override
  Widget build(BuildContext context) {
    context.read<FoodCubit>().getFoods(restaurantId);
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back)),
              Expanded(
                child: Center(
                  child: Text(
                    "Food List - $restaurantName",
                    style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<FoodCubit, FoodState>(
              builder: (context, state) {
                if(state.getStatus == GetFoodStatus.loading){
                  return Center(child: CircularProgressIndicator(color: AppColors.primary,),);
                }
                if(state.foods.isEmpty){
                  return Center(child: Text("No food added yet",style: TextStyle(
                    color: AppColors.primary,fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),);
                }
                return ListView.builder(
                  itemCount: state.foods.length,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: (context, index) {
                    final food = state.foods[index];
                    return FoodCard(
                     name: food['name'] ?? "",
                      price: food['price']?.toString() ?? '0',
                      image: food['image'] ?? "",
                      onDelete: (){
                       context.read<FoodCubit>().deleteFood(
                           restaurantId: restaurantId,
                           foodId: food['id'],
                       );
                      },
                      onEdit:() => onEditFood(food),
                    );
                  },
                );
              },
            ),
          ),
          Padding(padding: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ManageBtn(label: "Add Food",
                    icon: Icons.add, color: AppColors.primary,
                    onTap: () {
                      onAddFood();
                    }),
              )
          )
        ],
      ),
    );
  }
}
