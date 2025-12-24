import 'package:flutter/material.dart';
import 'package:bena_food/Core/Colors/app_colors.dart';

class CustomDropdown extends StatefulWidget {
  final String hint;
  final List<String> items;
  final IconData prefixIcon;
  final Function(String?) onSelected;
  final Color? textColor;
  final Color? iconColor;
  final Color? fillColor;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.onSelected,
    required this.prefixIcon,
    this.textColor,
    this.iconColor,
    this.fillColor,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: widget.fillColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(widget.prefixIcon, color: widget.iconColor),
           SizedBox(width: 12),
          Expanded(
            child: DropdownButton<String>(
              value: selectedValue,
              hint: Text(widget.hint, style: TextStyle(color: widget.textColor)),
              isExpanded: true,
              underline:  SizedBox(),
              icon:  Icon(Icons.keyboard_arrow_down_rounded, color: widget.iconColor),
              items: widget.items.map((String item) {
                return DropdownMenuItem<String>(

                  value: item,
                  child: Text(item, style: TextStyle(color: AppColors.black)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue;
                });
                widget.onSelected(newValue);
              },
              menuMaxHeight: 300,
            ),
          ),
        ],
      ),
    );
  }
}