import 'package:chat_with_me_now/models/massage_model.dart';
import 'package:flutter/material.dart';

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.massage,
    required this.alignment,
    required this.color,
    this.bottomLeft = 0,
    this.bottomRight = 0,
  });
  final MassageModel massage;
  final AlignmentGeometry alignment;
  final Color color;
  final double bottomLeft;
  final double bottomRight;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
          minWidth: 50,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
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

class MyChatBubble extends StatelessWidget {
  const MyChatBubble({super.key, required this.massage});
  final MassageModel massage;
  @override
  Widget build(BuildContext context) {
    return _ChatBubble(
      massage: massage,
      alignment: AlignmentGeometry.bottomLeft,
      color: Color(0xff324D69),
      bottomRight: 30,
    );
  }
}

class FriendChatBubble extends StatelessWidget {
  const FriendChatBubble({super.key, required this.massage});
  final MassageModel massage;
  @override
  Widget build(BuildContext context) {
    return _ChatBubble(
      massage: massage,
      alignment: AlignmentGeometry.bottomRight,
      color: Color(0xff006488),
      bottomLeft: 30,
    );
  }
}
