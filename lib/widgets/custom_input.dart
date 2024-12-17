import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isReadOnly;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.isReadOnly = false,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Spacing between inputs
      decoration: BoxDecoration(
        color: isReadOnly ? Colors.grey[200] : Colors.white,
        borderRadius: BorderRadius.circular(12.0), // Smooth rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Subtle shadow
            offset: const Offset(0, 4),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        readOnly: isReadOnly,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade500, // Light grey hint text
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14.0, // Padding inside the input
            horizontal: 16.0,
          ),
          border: InputBorder.none, // Removes default borders
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.grey.shade300, // Light grey border
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.blue, // Highlighted border color
              width: 2.0,
            ),
          ),
        ),
        style: TextStyle(
          color: isReadOnly ? Colors.grey : Colors.black, // Text color
          fontSize: 16.0,
        ),
      ),
    );
  }
}