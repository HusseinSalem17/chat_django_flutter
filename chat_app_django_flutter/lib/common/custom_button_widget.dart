import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool primary;
  final Icon? icon; // Add this line
  const CustomButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.primary = false,
    this.icon, // And this line
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 48,
        child: primary
            ? Material(
                elevation: 5.0,
                shadowColor: Colors.grey,
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: OutlinedButton.icon( // Change this line
                  icon: icon ?? const Icon(null), // Add this line
                  label: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none,
                  ),
                ),
              )
            : Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: OutlinedButton.icon( // Change this line
                  icon: icon ?? Icon(null), // Add this line
                  label: Text(text),
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none,
                  ),
                ),
              ));
  }
}
