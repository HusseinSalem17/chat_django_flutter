import 'package:chat_app_django_flutter/common/custom_button_widget.dart';
import 'package:chat_app_django_flutter/common/custom_text_fields.dart';
import 'package:chat_app_django_flutter/features/authenication_feature/sign_up_screen.dart';
import 'package:chat_app_django_flutter/features/home_feature/home_screen.dart';
import 'package:chat_app_django_flutter/models/user.dart';
import 'package:chat_app_django_flutter/utlis/hive_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  String username = '', password = '';
  final _formKey = GlobalKey<FormState>();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Real Time Chat',
                style: GoogleFonts.zillaSlab(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32.0),
              CustomTextField(
                labelText: 'Username',
                isObscure: false,
                onChanged: (value) {
                  username = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                labelText: 'Password',
                isObscure: true,
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              CustomButtonWidget(
                onPressed: () async {
                  debugPrint('here sign in');
                  if (_formKey.currentState!.validate()) {
                    Dio dio = Dio();
                    debugPrint('username: $username, password: $password');
                    await dio
                        .post(
                      'http://127.0.0.1:8000/chat/signin/',
                      data: {
                        'username': username,
                        'password': password,
                      },
                      options: Options(
                        headers: {
                          "Origin": "http://127.0.0.1:8000",
                        },
                      ),
                    )
                        .then((value) async {
                      if (value.statusCode == 200) {
                        try {
                          debugPrint('Sign in successful ${value.data}');

                          // Parse the response data to User object
                          User user = User.fromJson(value.data['user']);
                          
                          TokenData tokens =
                              TokenData.fromJson(value.data['tokens']);

                          // Save user data to Hive
                          print('userJson: ${user.toJson()}');
                          await HiveManager.saveData(
                            'userBox',
                            'userData',
                            user.toJson(),
                          );

                          // Save token data to shared preferences
                          await TokenManager.init();
                          TokenManager.saveTokens(tokens);
                          // Navigate to the home screen
                          debugPrint(
                              'tokens ${TokenManager.getTokens()!.accessToken}');
                          debugPrint('user before home: ${user.username}');
                          debugPrint('user before home: ${user.name}');
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => HomeScreen(user: user),
                            ),
                          );
                        } catch (e) {
                          debugPrint('Error occurred: $e');
                        }
                      }
                    }).catchError((e) {
                      if (e is DioException) {
                        // Handle Dio errors
                        debugPrint('here');
                        debugPrint(
                          'Dio error: ${e.response?.statusCode} - ${e.response?.statusCode} response: ${e.response?.data}',
                        );
                      } else {
                        // Handle other errors
                        debugPrint(e.toString()); // Print the error message
                      }
                    });
                  }
                },
                primary: true,
                text: "Sign in",
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SignUpScreen(),
                    ),
                  );
                },
                text: "Sign Up",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
