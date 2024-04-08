import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onSearchPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onProfilePressed,
    this.onSearchPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.grey[200],
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.account_circle,
          size: 32,
        ), // Add profile icon
        onPressed: onProfilePressed,
      ),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ), // Center the title
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
            size: 32,
          ), // Add search icon
          onPressed: onSearchPressed,
        ),
      ],
      elevation: 0.8, // Add shadow to AppBar
    );
  }
}
