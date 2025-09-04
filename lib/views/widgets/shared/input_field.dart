import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType? textInputType;
  final String? label;
  const InputField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.textInputType,
    this.label = "non-password",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType ?? TextInputType.text,
      onChanged: (e) {
        debugPrint("Input written: $e");
      },
      style: TextStyle(
        color: Colors.black, // Text color
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      obscureText: label != "non-password" ? true : false,
      decoration: InputDecoration(
        hintText: hintText, // Hint text
        suffix: label != "non-password"
            ? Icon(Icons.visibility)
            : SizedBox.shrink(),

        hintStyle: TextStyle(
          color: Colors.grey, // Hint text color
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),

        filled: true, // Fill the background
        fillColor: Colors.grey[200], // Background color
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.grey, // Border color
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.grey, // Border when not focused
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.blue, // Border when focused
            width: 2,
          ),
        ),
      ),
    );
  }
}
