import 'package:flutter/material.dart';
import 'package:productcost/utils/colors.dart';

/// Model class for Dropdown Items
class DropdownItem {
  final int id;
  final String name;

  DropdownItem({required this.id, required this.name});
}

/// Custom Dropdown Widget
class CustomDropdown extends StatefulWidget {
  final List<DropdownItem> items;
  final Function(DropdownItem) onChanged;
  final DropdownItem? selectedItem;
  final String hintText;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.hintText = "Select an option",
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  DropdownItem? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<DropdownItem>(
      value: selectedValue,

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: darkColor,
            width: 0.5, // 🔹 Border width
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkColor, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkColor, width: 1.2),
        ),
      ),
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 16,
      ),
      hint: Text(
        widget.hintText,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      items: widget.items.map((DropdownItem item) {
        return DropdownMenuItem<DropdownItem>(
          value: item,
          child: Text(item.name),
        );
      }).toList(),
      icon: Icon(
        Icons.keyboard_arrow_down_sharp,
        size: 30,
        color: Colors.grey.shade600,
      ),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        if (value != null) {
          widget.onChanged(value);
        }
      },
    );
  }
}
