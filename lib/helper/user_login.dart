import 'package:chat_with_me_now/Views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> userLogin(
  BuildContext context,
  String email,
  String password,
) async {
  UserCredential userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
  Navigator.pushNamed(context, HomeView.id, arguments: email);
}
