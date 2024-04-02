import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_set_2/view/login/login.dart';
import 'package:flutter/material.dart';

class RegisterScreeen extends StatefulWidget {
  const RegisterScreeen({super.key});

  @override
  State<RegisterScreeen> createState() => _RegisterScreeenState();
}

class _RegisterScreeenState extends State<RegisterScreeen> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      try {
                        final userCredential = await _auth.createUserWithEmailAndPassword(
                            email: email.text.trim()!, password: pass.text.trim()!);

                        if (userCredential.user?.uid != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text("Sign up")),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Text(" go to login")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
