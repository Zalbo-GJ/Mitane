import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mitane/comp/homePage.dart';
import 'package:mitane/comp/login.dart';

class MyLog extends StatelessWidget {
  const MyLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}
