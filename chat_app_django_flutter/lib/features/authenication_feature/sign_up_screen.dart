import 'package:chat_app_django_flutter/common/custom_button_widget.dart';
import 'package:chat_app_django_flutter/common/custom_text_fields.dart';
import 'package:chat_app_django_flutter/features/home_feature/home_screen.dart';
import 'package:chat_app_django_flutter/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import the Google Fonts package

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  String username = '',
      password = '',
      firstName = '',
      lastName = '',
      retypePassword = '';
  final _formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centered the column
                children: <Widget>[
                  Text(
                    'Real Time Chat',
                    style: GoogleFonts.zillaSlab(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  CustomTextField(
                    labelText: 'Username',
                    onChanged: (value) {
                      username = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTextField(
                    labelText: 'First Name',
                    onChanged: (value) {
                      firstName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTextField(
                    labelText: 'Last Name',
                    onChanged: (value) {
                      lastName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
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
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTextField(
                    labelText: 'Re-type Password',
                    isObscure: true,
                    onChanged: (value) {
                      retypePassword = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please re-type your password';
                      }
                      if (value != password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  CustomButtonWidget(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Dio dio = Dio();
                        await dio.post(
                          'http://127.0.0.1:8000/chat/signup/',
                          data: {
                            'username': username,
                            'first_name': firstName,
                            'last_name': lastName,
                            'password': password,
                          },
                        ).then((value) async {
                          if (value.statusCode == 200) {
                            debugPrint('Sign up successful');

                            // Parse the response data to User object
                            User user = User.fromJson(value.data);

                            // Store user data using SharedPreferences
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            debugPrint('User: $user');
                            await prefs.setString('userData', user.toString());

                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => HomeScreen(user: user),
                              ),
                            );
                          }
                        }).catchError((e) {
                          if (e is DioException) {
                            // Handle Dio errors
                            debugPrint(
                              'Dio error: ${e.response?.statusCode} - ${e.response?.statusMessage} response: ${e.response?.data}',
                            );
                          } else {
                            // Handle other errors
                            debugPrint(e.toString()); // Print the error message
                          }
                          return e;
                        });
                      }
                    },
                    primary: true,
                    text: "Sign In",
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomButtonWidget(
                    text: 'Sign In',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
