import 'package:flutter/material.dart';
import 'package:palchat/create_account.dart';
import 'package:palchat/home_screen.dart';
import 'package:palchat/methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
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
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 35),
            ),
          ),
          Text(
            'Please sign in to continue',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 17),
          ),
          Padding(
            padding: const EdgeInsets.all(38.0),
            child: Column(
              children: [
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.red,
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _password,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.red,
                      ),
                      suffixIcon: Icon(Icons.key),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
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
                      if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        logIn(_email.text, _password.text).then((user) {
                          if (user != null) {
                            print('Login Successful');
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => HomeScreen()));
                          } else {
                            print('Login Failed');
                            setState(() {
                              isLoading = false;
                            });
                          }
                        });
                      } else {
                        print('Please Fill Up the Form Correctly');
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegisterPage()));
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
