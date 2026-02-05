import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/adminWidget/custom_text_field.dart';
import 'package:bena_food/Core/Widget/adminWidget/manage_btn.dart';
import 'package:bena_food/Feature/Admin/Manage%20Foods/manage/food_cubit.dart';
import 'package:bena_food/Feature/Admin/Manage%20Foods/manage/food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFood extends StatelessWidget {
  final String restaurantId;
  final VoidCallback onBack;

  AddFood({super.key, required this.restaurantId, required this.onBack});

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<FoodCubit, FoodState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state.status == FoodStatus.addSuccess) {
            Fluttertoast.showToast(
              msg: "Add Food Successfully!",
              backgroundColor: Colors.green,
              textColor: AppColors.white,
              gravity: ToastGravity.TOP,
            );
            onBack();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back)),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Add New Food",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Text(
                  "Food Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: nameController,
                  hint: "Pizza, Burger...",
                ),
                SizedBox(height: 15),
                Text(
                  "Price (DA)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 8),
                CustomTextField(controller: priceController, hint: "e.g. 450"),
                SizedBox(height: 15),
                Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: descController,
                  hint: "What's in this meal?",
                ),
                SizedBox(height: 15),
                Text(
                  "Image",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: context.read<FoodCubit>().pickFoodImage,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(30),
                      borderRadius: BorderRadius.circular(15),
                      // image: state.foodImage!= null
                      //  ? DecorationImage(image: FileImage(state.foodImage!), fit: BoxFit.cover)
                      //    :null,
                    ),
                    child: state.foodImage == null
                        ? Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: AppColors.primary,
                            ),
                          )
                        : null,
                  ),
                ),

                SizedBox(height: 15),
                Text(
                  "Category",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: state.category,
                      isExpanded: true,
                      items: ["Pizza", "Burger", "Drinks", "Dessert"]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) =>
                          context.read<FoodCubit>().changeCategory(val!),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: state.availability == "Available"
                        ? Colors.green.withAlpha(20)
                        : Colors.red.withAlpha(20),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: state.availability == "Available"
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      Switch(
                        value: state.availability == "Available",
                        activeColor: Colors.green,
                        onChanged: (val) {
                          context.read<FoodCubit>().changeAvailability(
                            val ? "Available" : "Unavailable",
                          );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: state.status == FoodStatus.loading
                        ? null
                        : () {
                            context.read<FoodCubit>().addFood(
                              restaurantId: restaurantId,
                              name: nameController.text,
                              price: priceController.text,
                              description: descController.text,
                            );
                          },

                    child: state.status == FoodStatus.loading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : Text(
                            "Save Food",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
