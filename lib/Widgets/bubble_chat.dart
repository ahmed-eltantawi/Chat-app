import 'package:chat_with_me_now/models/massage_model.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  const BubbleChat({super.key, required this.massage});
  final MassageModel massage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
          minWidth: 50,
        ),
        decoration: BoxDecoration(
          color: Color(0xff324D69),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(15),
        child: Text(
          massage.massage,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
