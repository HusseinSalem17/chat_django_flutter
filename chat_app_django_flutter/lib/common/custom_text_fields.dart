import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String labelText;
  final bool isObscure;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.isObscure = false,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        obscureText: isObscure,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          fillColor: Colors.grey[200], // Change the color of the text field
          filled: true,
          border: InputBorder.none, // Remove the border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
