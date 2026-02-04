import 'dart:developer';

import 'package:chat_with_me_now/Views/chat_view_between_two.dart';
import 'package:chat_with_me_now/Views/drawer_view.dart';
import 'package:chat_with_me_now/helper/consts.dart';
import 'package:chat_with_me_now/models/friend_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  static String id = 'HomeView';

  final CollectionReference friends = FirebaseFirestore.instance.collection(
    kFriendsCollection,
  );

  List<FriendModel> friendList = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: friends.orderBy('createdAt').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.hasData) {
          friendList.clear();
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            friendList.add(FriendModel.fromJson(snapshot.data!.docs[i]));
          }
        }
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,

          appBar: AppBar(
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,

            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'H O M E',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),

          drawer: DrawerView(),
          body: snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return FriendWidget(friendModel: friendList[index]);
                    },
                  ),
                ),
        );
      },
    );
  }
}

class FriendWidget extends StatelessWidget {
  FriendWidget({super.key, required this.friendModel});

  final FriendModel friendModel;
  late String chatId;

  @override
  Widget build(BuildContext context) {
    String userEmail = ModalRoute.of(context)!.settings.arguments as String;

    var circleAvatar = CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.secondary,

      radius: 30,
      child: Text(
        friendModel.name[0],
        style: TextStyle(
          fontSize: 30,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
    return GestureDetector(
      onTap: () {
        getChatId(userEmail);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ChatViewBetweenTwo(
                email: userEmail,
                chatId: chatId,
                friendName: friendModel.name,
                friendImage: circleAvatar,
              );
            },
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            color: Colors.transparent,
            width: double.infinity,
            height: 80,
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    circleAvatar,
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            friendModel.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Ahmed khaled', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getChatId(String userEmail) {
    if (userEmail.toLowerCase().compareTo(friendModel.id.toLowerCase()) < 0) {
      chatId = userEmail + friendModel.id;
    } else {
      chatId = friendModel.id + userEmail;
    }
  }
}
