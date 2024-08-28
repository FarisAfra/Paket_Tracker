import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';

class CustomDropdown extends StatefulWidget {
  final double width;
  final double height;
  final String icons;
  final double sizeicons;
  final String hintText;
  final List<Map<String, dynamic>> items; // List of items with text and image path
  final ValueChanged<String?>? onChanged;
  final String? value;

  const CustomDropdown({
    this.width = 262,
    this.height = 36,
    this.sizeicons = 24,
    required this.icons,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.value,
    super.key
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: AppColors.Putih,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: SizedBox(
              width: widget.sizeicons,
              height: widget.sizeicons,
              child: Image.asset(widget.icons, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              hint: Text(
                widget.hintText,
                style: AppFonts.poppinsRegular(
                    fontSize: 12, color: AppColors.AbuMuda),
              ),
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.Hitam),
              underline: SizedBox(), // Removes the underline
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              },
              items: widget.items.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item['value'],
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.Putih,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                    children: [
                      Image.asset(
                        item['icon'],
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item['label'],
                        style: AppFonts.poppinsRegular(
                            fontSize: 12, color: AppColors.Hitam),
                      ),
                    ],
                  ),)
                  )
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
