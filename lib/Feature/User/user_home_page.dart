import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/main%20scaffold%20user/main_scaffold.dart';
import 'package:bena_food/Core/Widget/userWidget/category_item.dart';

import 'package:bena_food/Core/Widget/userWidget/restaurant_card.dart';
import 'package:bena_food/Feature/User/manager/user_home_cubit.dart';
import 'package:bena_food/Feature/User/manager/user_home_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserHomePage extends StatelessWidget {
  final Function(Map<String, dynamic>) onRestaurantTap;

  const UserHomePage({super.key,required this.onRestaurantTap});

  @override
  Widget build(BuildContext context) {
    context.read<UserHomeCubit>().homeData();
    return SafeArea(
      child: BlocBuilder<UserHomeCubit, UserHomeState>(
        builder: (context, state) {
          if(state.status == UserHomeStatus.loading){
            return Center(child: CircularProgressIndicator(),);
          }
          final filteredRestaurants = state.selectedCategory == "All"
          ? state.restaurants
              : state.restaurants.where((r) => r.category == state.selectedCategory).toList();
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(height:20,),
                Row(
                  children: [
                    Image.asset("assets/logo/bena_food.png", width: 120,),
                    SizedBox(width: 170,),
                    Row(
                      children: [
                        Stack(
                          children: [
                            Icon(
                              Icons.notifications,
                              size: 30,
                              color: AppColors.black,
                            ),
                            Positioned(
                              right: 0,
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
      
                    Icon(Icons.more_vert, size: 30, color: AppColors.black,),
                  ],
                ),
      
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        Icons.person, color: AppColors.white, size: 35,),
                    ),
                    SizedBox(width: 15,),
                    Text("Hi ${FirebaseAuth.instance.currentUser?.displayName ?? 'Client'}", style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    ),
      
                  ],
                ),
      
                SizedBox(height: 10,),
                Text("What Would You Like To Eat Today?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search Dishes, drinks, etc...",
                          hintStyle: TextStyle(color: AppColors.white),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
      
                    ),
      
      
                    ),
                    SizedBox(width: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text("Filters", style: TextStyle(
                              color: AppColors.white),),
                          Icon(Icons.arrow_drop_down, color: AppColors.white,),
                        ],
                      ),
                    )
                  ],
                ),
      
                SizedBox(height: 10,),
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: state.categories.map((cat) => CategorItem(
                        title: cat,
                        isSelected: state.selectedCategory == cat,
                        onTap: () => context.read<UserHomeCubit>().changeCategory(cat),
                    )).toList(),
                  ),
                ),
      
                SizedBox(height: 25,),
                GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(15),
                    itemCount: filteredRestaurants.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.75
                    ),
                    itemBuilder: (context,index){
                      final res = filteredRestaurants[index];
                      return RestaurantCard(
                          name: res.name,
                          status: res.status,
                          imagePath: res.image,
                         onTap: (){
                           onRestaurantTap({
                             'id': res.id,
                             'name': res.name,
                             'image':res.image,
                           });
                         }
                      );
                    })
              ],
      
            ),
      
      
          );
        },
      ),
    );
  }
}
