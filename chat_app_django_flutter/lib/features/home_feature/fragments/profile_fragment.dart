import 'dart:io';

import 'package:chat_app_django_flutter/common/custom_app_bar.dart';
import 'package:chat_app_django_flutter/common/custom_button_widget.dart';
import 'package:chat_app_django_flutter/features/authenication_feature/sign_in_screen.dart';
import 'package:chat_app_django_flutter/utlis/web_sockets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chat_app_django_flutter/models/user.dart'; // Import the User class

class ProfileFragment extends StatefulWidget {
  final User user; // Declare a field to store the User object
  final WebSocketManager
      webSocket; // Declare a field to store the WebSocketManager object

  const ProfileFragment(
      {super.key, required this.user, required this.webSocket});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  File? _image;
  @override
  void initState() {
    super.initState();
    debugPrint('User: ${widget.user.username}');
    debugPrint('User: ${widget.user.name}');
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.webSocket.sendThumbnail(_image!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        onProfilePressed: () {
          // Handle the profile action
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile icon pressed'),
            ),
          );
        },
        onSearchPressed: () {
          // Handle the search action
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Search icon pressed'),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: _image != null
                      ? Image.file(File(_image!.path)).image
                      : const AssetImage(
                          'assets/images/user.png',
                        ) as ImageProvider<Object>?, // Replace with your image
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: _getImage,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              'Name: ${widget.user.username}',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20.0),
            CustomButtonWidget(
              text: 'Logout',
              primary: true,
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
