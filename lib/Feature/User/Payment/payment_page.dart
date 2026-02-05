import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/userWidget/build_section.dart';
import 'package:bena_food/Core/Widget/userWidget/contact_field.dart';
import 'package:bena_food/Core/Widget/userWidget/payment_title.dart';
import 'package:bena_food/Feature/User/Payment/payment_failed_page.dart';
import 'package:bena_food/Feature/User/Payment/success_order_page.dart';
import 'package:bena_food/Feature/User/cart/manager/cart_cubit.dart';
import 'package:bena_food/Feature/User/cart/manager/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentPage extends StatelessWidget {
  final double totalAmount;
  final VoidCallback onBack;
  final String restaurantName;
  final Function(String status) onOrderStatusChanged;


   const PaymentPage({
    super.key,
    required this.totalAmount,
    required this.onBack,
     required this.onOrderStatusChanged,
    required this.restaurantName ,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

    return SafeArea(
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state.status == CartStatus.success) {

            onOrderStatusChanged("success");
          } else if (state.status == CartStatus.error) {

            onOrderStatusChanged("error");
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back), onPressed: onBack),

                    Expanded(
                      child: Center(
                        child: Text(
                          "Payment",
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
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Total: $totalAmount DA",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                buildSection(
                  title: "Choose Payment Methode :",
                  items: [
                    paymentTile(
                       context,
                        "Cash On Delivery", Icons.account_balance_wallet,
                        state.selectedPaymentMethod
                    ),
                    Divider(),
                    paymentTile(context,"Credit Card", Icons.credit_card,state.selectedPaymentMethod),
                  ],
                ),

                SizedBox(height: 20),

                buildSection(
                  title: "Contact Info :",
                  items: [
                    contactField(phoneController,Icons.phone, "Phone Number"),
                    SizedBox(height: 10),
                    contactField(addressController,Icons.location_on, "Address"),
                  ],
                ),

                SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: state.status == CartStatus.loading
                    ? null
                        :() {
                       if(phoneController.text.isNotEmpty && addressController.text.isNotEmpty){
                         context.read<CartCubit>().placeOrder(
                             phone: phoneController.text,
                             address: addressController.text,
                             restaurantName:restaurantName,
                         );
                       }else{
                         Fluttertoast.showToast(msg: "Please fill all contact info",
                           backgroundColor: Colors.red,
                           textColor: AppColors.white,
                           gravity: ToastGravity.TOP,
                         );
                       }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: state.status == CartStatus.loading
                    ? Center(child: CircularProgressIndicator(color: Colors.black),)
                    :Text(
                      "Place Order",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
