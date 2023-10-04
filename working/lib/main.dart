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
        body: Center(
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snap) => Column(
              mainAxisSize: MainAxisSize.min,
              children: snap.data != null
                  ? const [
                      Text('Signed in'),
                      Text('Refreshing the page should NOT result in sign out'),
                    ]
                  : [
                      const Text('Signed out'),
                      ElevatedButton(
                        onPressed: FirebaseAuth.instance.signInAnonymously,
                        child: const Text('Sign in'),
                      ),
                    ],
            ),
          ),
        ),
      ),
    ),
  );
}
