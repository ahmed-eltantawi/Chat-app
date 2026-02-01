import 'package:chat_with_me_now/Widgets/bubble_chat.dart';
import 'package:chat_with_me_now/helper/consts.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});
  static String id = 'ChatView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kAppIcon, height: 65),
            Text("Chat", style: TextStyle(color: Colors.white, fontSize: 23)),
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return BubbleChat(massage: 'Hello this wwwwworld');
        },
      ),
    );
  }
}
