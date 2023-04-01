import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatRoom extends StatelessWidget {
  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, dynamic> userMap;
  final String chatRoomId;
  ChatRoom({super.key, required this.userMap, required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(userMap['name'])),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: size.height / 1.25,
            width: 150,
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chatroom')
                  .doc(chatRoomId)
                  .collection('chats')
                  .orderBy('time', descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return Text(snapshot.data?.docs[index]['message']);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      )),
      bottomNavigationBar: Container(
        height: size.height / 10,
        width: size.width,
        child: Container(
          height: size.height / 5,
          width: size.width,
          alignment: Alignment.center,
          child: Row(
            children: [
              Container(
                height: size.height / 12,
                width: size.width / 1.5,
                child: TextField(
                  controller: _message,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.send))
            ],
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
