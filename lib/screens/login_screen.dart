import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool modal_progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
        child: Builder(builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your UserName.'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password.'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    final progress = ProgressHUD.of(context);
                    progress?.show();

                    final newUer = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    try {
                      if (newUer != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      progress?.dismiss();
                    } catch (e) {
                      print(e);
                    }
                  },
                  text: 'Log In',
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
