import 'package:chat_with_me_now/Views/chat_view.dart';
import 'package:chat_with_me_now/Views/friends_view.dart';
import 'package:chat_with_me_now/Views/login_view.dart';
import 'package:chat_with_me_now/Views/register_view.dart';
import 'package:chat_with_me_now/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ChatView.id: (context) => ChatView(),
        LoginView.id: (context) => LoginView(),
        RegisterView.id: (context) => RegisterView(),
        FriendsView.id: (context) => FriendsView(),
      },
      initialRoute:
          //  FriendsView.id,
          LoginView.id,
    );
  }
}
