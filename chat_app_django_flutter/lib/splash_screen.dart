import 'package:chat_app_django_flutter/common/title.dart';
import 'package:chat_app_django_flutter/features/authenication_feature/sign_in_screen.dart';
import 'package:chat_app_django_flutter/features/home_feature/home_screen.dart';
import 'package:chat_app_django_flutter/models/user.dart';
import 'package:chat_app_django_flutter/utlis/hive_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Wait for 3 seconds and then navigate to the Home Screen
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        await TokenManager.init();
        final userData = await HiveManager.getData('userBox', 'userData');
        debugPrint('User: $userData');
        if (userData != null) {
          User user = User.fromJson(userData);
          debugPrint('User2: $userData');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(user: user),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Show the status bar
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.purpleAccent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              titleWidget(),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
