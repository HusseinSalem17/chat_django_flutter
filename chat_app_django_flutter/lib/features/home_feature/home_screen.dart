import 'package:chat_app_django_flutter/utlis/web_sockets.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_django_flutter/features/home_feature/fragments/friends_fragment.dart';
import 'package:chat_app_django_flutter/features/home_feature/fragments/profile_fragment.dart';
import 'package:chat_app_django_flutter/features/home_feature/fragments/request_fragment.dart';
import 'package:chat_app_django_flutter/models/user.dart'; // Import the User class

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late WebSocketManager _webSocketManager; // Declare WebSocketManager instance

  @override
  void initState() {
    super.initState();
    // Connect to WebSocket server when HomeScreen initializes
    _webSocketManager = WebSocketManager(TokenManager.getTokens());
    print('UserHome: ${widget.user.name}');
    print('UserHome: ${widget.user.username}');
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      debugPrint('user: ${widget.user.name}');
      debugPrint('user: ${widget.user.username}');
    });
  }

  @override
  void dispose() {
    // Close WebSocket connection when HomeScreen is disposed
    _webSocketManager.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      const RequestFragment(),
      const FriendsFragment(),
      ProfileFragment(user: widget.user, webSocket: _webSocketManager),
    ];

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: children[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Requests',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
