import 'package:chat_app_django_flutter/common/custom_app_bar.dart';
import 'package:flutter/material.dart';

class RequestFragment extends StatelessWidget {
  const RequestFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Requests',
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
      body: const Center(
        child: Text('Requests Tab'),
      ),
    );
  }
}
