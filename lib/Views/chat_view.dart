import 'dart:developer';

import 'package:chat_with_me_now/Widgets/chat_bubble.dart';
import 'package:chat_with_me_now/helper/consts.dart';
import 'package:chat_with_me_now/models/massage_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  static String id = 'ChatView';

  @override
  State<ChatView> createState() => _ChatViewState();
}

final ScrollController _scrollController = ScrollController();

class _ChatViewState extends State<ChatView> {
  CollectionReference massages = FirebaseFirestore.instance.collection(
    kMassagesCollection,
  );

  TextEditingController controller = TextEditingController();

  List<MassageModel> massagesList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: massages
          .orderBy(kCreatedAtCollection, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.hasData) {
          massagesList.clear();
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            massagesList.add(MassageModel.fromJson(snapshot.data!.docs[i]));
          }
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: kPrimaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(kAppIcon, height: 65),
                Text(
                  "Chat",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
              ],
            ),
          ),
          body: snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return massagesList[index].id == email
                              ? MyChatBubble(massage: massagesList[index])
                              : FriendChatBubble(massage: massagesList[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 30,
                        top: 16,
                      ),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (value) {
                          if (value == '') {
                            return;
                          }
                          massages.add({
                            'text': value,
                            kCreatedAtCollection: DateTime.now(),
                            'id': email,
                          });
                          controller.clear();
                          _scrollController.animateTo(
                            0,
                            duration: Duration(milliseconds: 3000),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                        decoration: InputDecoration(
                          hintText: 'Sent Massage',
                          suffixIcon: Icon(Icons.send),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
