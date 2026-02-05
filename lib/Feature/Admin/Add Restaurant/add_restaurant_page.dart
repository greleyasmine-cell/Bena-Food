import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/main%20scaffold%20admin/admin_layout.dart';
import 'package:bena_food/Core/Componants/main%20scaffold%20user/main_scaffold.dart';
import 'package:bena_food/Core/Componants/main%20scaffold%20admin/main_scaffold_admin.dart';
import 'package:bena_food/Core/Widget/adminWidget/custom_text_field.dart';
import 'package:bena_food/Core/Widget/adminWidget/status_button.dart';
import 'package:bena_food/Feature/Admin/Add%20Restaurant/manager/add_restaurant_cubit.dart';
import 'package:bena_food/Feature/Admin/Add%20Restaurant/manager/add_restaurant_state.dart';
import 'package:bena_food/Feature/Admin/admin_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRestaurantPage extends StatelessWidget {
  final VoidCallback onBack;
   AddRestaurantPage({super.key,required this.onBack});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AddRestaurantCubit, AddRestaurantState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state.status == AddRestaurantStatus.success){
            Fluttertoast.showToast(msg: "Restaurant Added Successfully!",
            backgroundColor: Colors.green,
              textColor: AppColors.white,
              gravity: ToastGravity.TOP,
            );
      
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => AdminLayout()),
                (route) => false);
      
          }
          if(state.status == AddRestaurantStatus.error){
            Fluttertoast.showToast(
                msg: state.errorMessage ?? "Error Occurred",
                backgroundColor: Colors.red,
                textColor: AppColors.white,
            );
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
                    Expanded(child: Center(child: Text("Add Restaurant",style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.bold,fontSize: 22),))),
                  ],
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: context.read<AddRestaurantCubit>().resImage,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(30),
                      borderRadius: BorderRadius.circular(15),
                     // image: state.image != null
                      //  ? DecorationImage(image: FileImage(state.image!), fit: BoxFit.cover)
                      //    :null,
                    ),
                    child: state.image == null
                    ? Center(child: Icon(Icons.add_a_photo,size: 40,color: AppColors.primary,),)
                    : null,
                  ),
                ),
      
                SizedBox(height: 25,),
      
                Text("Restaurant Name",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary),),
                SizedBox(height: 8,),
                CustomTextField(controller: nameController,
                    hint: "Enter restaurant name"),
      
                SizedBox(height: 20,),
                Text("Description",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary),),
                SizedBox(height: 8,),
                CustomTextField(
                    controller: descController,
                    hint: "Tell us about it....",
                    maxLines: 3
                ),
      
                SizedBox(height: 20,),
      
                Text("Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                SizedBox(height: 10,),
                Row(
                  children: [
                    StatusButton(
                        context.read<AddRestaurantCubit>(),
                        "Open",
                        Colors.green,
                        state.restaurantStatus == "Open"),
                    SizedBox(width: 10,),
                    StatusButton(
                        context.read<AddRestaurantCubit>(),
                        "Close",
                        Colors.red,
                        state.restaurantStatus == "Close",
      
                    ),
                  ],
                ),
      
                SizedBox(height: 40,),
      
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                      onPressed: state.status == AddRestaurantStatus.loading
                      ?null
                      :() => {
                        if(nameController.text.isNotEmpty){
                          context.read<AddRestaurantCubit>().saveRestaurant(
                            name: nameController.text,
                            description: descController.text,
                            restaurantStatus: state.restaurantStatus ?? "Open",
                          )
                        }else{
                          Fluttertoast.showToast(msg: "Please enter a name"),
                        }
                      }
                          ,
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                      child: state.status == AddRestaurantStatus.loading
                      ? CircularProgressIndicator(color: AppColors.primary,)
                          : Text ("Save Restaurant",style: TextStyle(color: AppColors.white),),
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
