import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final bool? isPassword;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final Color? textColor;
  final Color? iconsColor;



  const CustomTextfield({
    super.key,
    required this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.isPassword,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.fillColor,
    this.textColor,
    this.iconsColor,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool isObscureText = false;
  @override
  void initState(){
    super.initState();
    isObscureText = widget.obscureText;
  }
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.isPassword == true ? isObscureText : false,
      keyboardType: widget.keyboardType,
      style: TextStyle(color: AppColors.black),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: widget.textColor),
        filled: true,
        fillColor: widget.fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
        prefixIcon: widget.prefixIcon != null
          ?Icon(widget.prefixIcon,color: widget.iconsColor,)
            :null,
        suffixIcon: widget.isPassword == true
          ?GestureDetector(
          onTap: (){
            setState(() {
              isObscureText = !isObscureText;
            });
          },child: Icon(
          isObscureText
            ?Icons.visibility
              :Icons.visibility_off,
          color: widget.iconsColor,
        ),
        ):(widget.suffixIcon != null
        ?Icon(widget.suffixIcon,color: widget.iconsColor,)
        :null
        ),
      ),
    );
  }
}
