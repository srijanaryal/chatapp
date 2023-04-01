import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:palchat/chat_room.dart';
import 'package:palchat/main.dart';
import 'package:palchat/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authenticate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic> userMap = {};
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2[0].toLowerCase().codeUnits[0]) {
      return "user2$user1";
    } else {
      return "user1$user2";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            MaterialButton(
              onPressed: () {
                logOut(BuildContext, context);
              },
              child: Text(
                'LOGOUT ',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                  hintText: 'Search...',
                  hintStyle:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(
              child: Container(
                child: MaterialButton(
                  onPressed: onSearch,
                  child: Text('Search '),
                ),
              ),
            ),
            if (userMap.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListTile(
                  onTap: () {
                    String? displayName = _auth.currentUser?.displayName;
                    if (displayName != null) {
                      String roomId = chatRoomId(displayName, userMap['name']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatRoom(
                            chatRoomId: roomId,
                            userMap: userMap,
                          ),
                        ),
                      );
                    }
                  },
                  trailing: IconButton(
                    icon: Icon(
                      Icons.message,
                    ),
                    onPressed: () {},
                  ),
                  leading: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                  title: Text(userMap['name']),
                  subtitle: Text(userMap['email']),
                ),
              )
            else if (isLoading)
              CircularProgressIndicator()
            else
              Container(
                child: Text('Sorry no email is found'),
              ),
          ],
        ),
      ),
    );
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs.isNotEmpty ? value.docs[0].data() : {};
        isLoading = false;
      });
      print(userMap);
    });
  }
}
