import 'package:chad/screens/auth_screen.dart';
import 'package:chad/screens/teams_screen.dart';
import 'package:chad/theme/theme_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(appBar: AppBar(title: const Text('Une erreur est survenue.'),),),)
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Who\'s Chad',
              theme: lightTheme,
              home: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, stream) {
                if (stream.hasData) {
                  return const TeamScreen();
                } else {
                  return const AuthScreen();
                }
              }),
            );
          }
          return MaterialApp(
              home: Scaffold(
                appBar: AppBar(
                  title: const Text('Loading'),
                ),
              )
          );
        }
    );
  }
}
