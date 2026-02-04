import 'dart:developer';

import 'package:chat_with_me_now/Views/register_view.dart';
import 'package:chat_with_me_now/Widgets/custom_bottom.dart';
import 'package:chat_with_me_now/Widgets/custom_text_field.dart';
import 'package:chat_with_me_now/helper/consts.dart';
import 'package:chat_with_me_now/helper/show_snack_bar.dart';
import 'package:chat_with_me_now/helper/user_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:email_validator/email_validator.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email;

  String? password;

  final GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Spacer(flex: 1),
                  Image.asset(kAppIcon),
                  Text(
                    'Scalar Chat',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  Row(
                    children: [Text('Sign In', style: TextStyle(fontSize: 25))],
                  ),
                  SizedBox(height: 10),
                  CustomFormTextField(
                    hintText: 'Email',
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: 15),
                  CustomFormTextField(
                    hide: true,
                    hintText: 'Password',
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomBottom(
                    text: 'Sign In',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        final bool isConnected =
                            await InternetConnection().hasInternetAccess;
                        if (!isConnected) {
                          showSnackBar(context, 'No internet connection.');
                        } else {
                          if (!EmailValidator.validate(email!)) {
                            showSnackBar(
                              context,
                              'Email is not valid email, try To enter a right one',
                            );
                          } else {
                            try {
                              await userLogin(context, email!, password!);
                              email = '';
                              password = '';
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                showSnackBar(
                                  context,
                                  'No user found for that email.',
                                );
                              } else if (e.code == 'invalid-credential') {
                                showSnackBar(
                                  context,
                                  'Wrong password provided for that user.',
                                );
                              }
                            } catch (e) {
                              showSnackBar(
                                context,
                                'There some thing Wrong, please try again',
                              );
                            }
                          }
                        }

                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't Have an account?  ", style: TextStyle()),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterView.id);
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
