import 'package:chat_with_me_now/Views/chat_view.dart';
import 'package:chat_with_me_now/helper/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> userLogin(
  BuildContext context,
  String email,
  String password,
) async {
  UserCredential userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
  Navigator.pushNamed(context, ChatView.id);
  showSnackBar(context, 'successful');
}
