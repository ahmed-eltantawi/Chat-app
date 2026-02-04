import 'package:chat_with_me_now/Views/chat_view.dart';
import 'package:chat_with_me_now/Views/error_view.dart';
import 'package:chat_with_me_now/Views/home_view.dart';
import 'package:chat_with_me_now/Views/login_view.dart';
import 'package:chat_with_me_now/Views/register_view.dart';
import 'package:chat_with_me_now/firebase_options.dart';
import 'package:chat_with_me_now/theme/dark_mode_them.dart';
import 'package:chat_with_me_now/theme/light_mode_theme.dart';
import 'package:chat_with_me_now/theme/theme_probider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      child: const ChatApp(),
      create: (context) => ThemeProvider(),
    ),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        ChatView.id: (context) => ChatView(),
        LoginView.id: (context) => LoginView(),
        RegisterView.id: (context) => RegisterView(),
        HomeView.id: (context) => HomeView(),
      },

      initialRoute: LoginView.id,
    );
  }
}
