import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Models/cart_model.dart';
import 'package:bena_food/Core/Widget/orDivider.dart';
import 'package:bena_food/Core/Widget/userWidget/info_tag.dart';
import 'package:bena_food/Feature/User/cart/manager/cart_cubit.dart';
import 'package:bena_food/Feature/User/cart/manager/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FoodDetailsPage extends StatelessWidget {
  final Map<String, dynamic> food;
  final VoidCallback onBack;

  const FoodDetailsPage({super.key, required this.food, required this.onBack});

  @override
  Widget build(BuildContext context) {
    bool isAvailable = food['status'] == "Available";
    double price = double.tryParse(food['price'].toString()) ?? 0;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back)),
                Expanded(
                  child: Center(
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 48),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade200, blurRadius: 10),
                  ],
                  border: Border.all(
                    color: AppColors.primary.withAlpha(50),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade200,
                              blurRadius: 10),
                        ],
                        border: Border.all(
                          color: AppColors.primary.withAlpha(50),
                          width: 2,
                        ),
                      ),
                      child: food['image'] != null && food['image'] != ""
                          ? Image.network(
                        food['image'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.primary,
                              ),
                              child: Icon(
                                Icons.restaurant,
                                size: 50,
                                color: AppColors.white,
                              ),
                            ),
                      )
                          : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primary,
                        ),
                        child: Icon(
                          Icons.restaurant,
                          size: 40,
                          color: AppColors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: 25),
                    Text(
                      food['name'] ?? 'Meal Name',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 1, color: AppColors.primary),
                    SizedBox(height: 10),
                    Text(
                      food['description'] ??
                          "No description available for this delicious meal.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 1, color: AppColors.primary),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        infoTag(
                          label: food['category'] ?? "General",
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 10),

                        infoTag(
                          icon: isAvailable
                              ? Icons.check_circle
                              : Icons.cancel,
                          label: isAvailable
                              ? "Available"
                              : "Not Available",
                          color: isAvailable
                              ? Colors.green
                              : Colors.red,
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    Divider(thickness: 1, color: AppColors.primary),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        Text(
                          "Price:",
                          style: TextStyle(fontWeight: .bold, fontSize: 17),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "$price DA",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),

          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${(price * state.detailQty).toStringAsFixed(0)} DA",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () => context.read<CartCubit>().decDetail(),
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "${state.detailQty}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => context.read<CartCubit>().incDetail(),
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isAvailable ? (){
                        final cartItem = CartModel(
                          id: food['id'] ?? UniqueKey().toString(),
                          name: food['name'] ?? "Meal",
                          price: price,
                          image: food['image'] ?? "",
                          quantity: state.detailQty,
                          ownerId: food['ownerId'] ?? "",
                          restaurantName: food['restaurantName'] ?? "Unknown Restaurant",
                        );
                        context.read<CartCubit>().addToCart(cartItem);
                        Fluttertoast.showToast(
                          msg: "Added to Cart successfully!",
                          backgroundColor: Colors.green,
                          textColor: AppColors.white,
                          gravity: ToastGravity.TOP,
                        );
                      }:null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        isAvailable ? "Add to Card" : "Unavailable",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
