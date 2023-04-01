import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'home_screen.dart';
import 'methods.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.back_hand,
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    'Welcome to PalChat',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                ),
                Text(
                  'Please sign in to continue',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.red,
                          ),
                          hintText: 'Name',
                          hintStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.red,
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.red,
                            ),
                            suffixIcon: Icon(Icons.key),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if (_name.text.isNotEmpty &&
                                _email.text.isNotEmpty &&
                                _password.text.isNotEmpty) {
                              setState(() {
                                isLoading = true;
                              });
                            }

                            createAccount(
                                    _name.text, _email.text, _password.text)
                                .then((user) {
                              if (user != null) {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => HomeScreen()));
                                print('Login Success');
                              } else {
                                print('Login Failed');
                              }
                            });
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: (Colors.white),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
    );
  }
}
