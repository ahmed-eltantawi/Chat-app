import 'dart:developer';

import 'package:chat_with_me_now/helper/consts.dart';
import 'package:chat_with_me_now/models/friend_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FriendsView extends StatelessWidget {
  FriendsView({super.key});
  static String id = 'FriendsView';

  final CollectionReference friends = FirebaseFirestore.instance.collection(
    kFriendsCollection,
  );

  List<FriendModel> friendList = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: friends.snapshots(),
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
                      return FriendWidget(name: friendList[index]);
                    },
                  ),
                ),
        );
      },
    );
  }
}

class FriendWidget extends StatelessWidget {
  const FriendWidget({super.key, required this.name});
  final FriendModel name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        width: double.infinity,
        color: Colors.grey,
        child: Center(child: Text(name.name)),
      ),
    );
  }
}
