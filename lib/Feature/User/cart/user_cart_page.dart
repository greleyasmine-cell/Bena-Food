import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/userWidget/qty_btn.dart';
import 'package:bena_food/Feature/User/cart/manager/cart_cubit.dart';
import 'package:bena_food/Feature/User/cart/manager/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCartPage extends StatelessWidget {
  final Function(double) onOrderNow;
  final VoidCallback onBack;
  const UserCartPage({super.key,required this.onOrderNow,required this.onBack});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.cartItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(icon: Icon(Icons.arrow_back), onPressed: onBack),

                        Expanded(
                          child: Center(
                            child: Text(
                              "Orders List",
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
                    SizedBox(height: 200,),
                    Icon(Icons.remove_shopping_cart,color: AppColors.primary,size: 60,),
                    SizedBox(height: 20,),
                    Text(
                      "Your cart is empty",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Column(
              children: [
                Text(
                  "Cart",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Icon(Icons.check_box, color: Colors.amber),
                              SizedBox(width: 10),
                              Text(
                                "Select all",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: ListView.separated(
                            itemCount: state.cartItems.length,
                            separatorBuilder: (context, index) =>
                                const Divider(color: Colors.white24),

                            itemBuilder: (context, index) {
                              final item = state.cartItems[index];
                              return ListTile(
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_box,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      child: (item.image.isEmpty )
                                          ? Icon(Icons.restaurant, color: AppColors.primary)
                                          : null,
                                      backgroundImage: (item.image.isNotEmpty)
                                          ? NetworkImage(item.image)
                                          : null,
                                    ),
                                  ],
                                ),
                                title: Text(
                                  item.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "${item.price} DA",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    qtyBtn(
                                      Icons.remove,
                                      () => context.read<CartCubit>().decrement(
                                        index,
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        "${item.quantity}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    qtyBtn(
                                      Icons.add,
                                      () => context.read<CartCubit>().increment(
                                        index,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total :",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${state.totalPrice} DA",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onOrderNow(state.totalPrice);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child:  Text(
                                "Order Now",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
