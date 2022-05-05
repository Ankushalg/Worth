
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'HomeScreen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Colors.redAccent,
            padding: const EdgeInsets.all(6.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              child: Center(
                child: SignInScreen(
                  sideBuilder: ((context, constraints) => SizedBox(height: 300, width: 300,child: Image.asset("images/logo.png"))),
                  headerBuilder: ((context, constraints, _) => Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Image.asset("images/logo.png")
                  )),
                  providerConfigs: const [EmailProviderConfiguration(),],
                ),
              ),
            ),
          );
        }
        return const HomeScreen();
      },
    );
  }
}