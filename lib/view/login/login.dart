import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_set_2/view/options_screen/options_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: pass,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final newUser =
                        await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: pass.text.trim());
                    if (newUser != null) {
                      print(_auth.currentUser?.email);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OptionsScreen(),
                          ),
                          (route) => false);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
