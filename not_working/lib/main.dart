import 'package:app_check_test/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webProvider:
        ReCaptchaV3Provider('6LfDr20oAAAAAP5gyaK1KnHu17DPMj7e8DYEemza'),
  );
  runApp(
    MaterialApp(
      home: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snap) {
            final user = snap.data;
            if (user != null) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Signed in'),
                    Text('Refreshing the page should result in sign out'),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Signed out'),
                    ElevatedButton(
                      onPressed: () =>
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: 'test@test.com',
                        password: 'pass12',
                      ),
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    ),
  );
}
