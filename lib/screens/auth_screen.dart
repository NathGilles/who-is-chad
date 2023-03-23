import 'package:chad/widgets/auth_form_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = FirebaseAuth.instance;
  var isLoading = false;

  void submitAuthForm (String email, String password, String nickName, bool isLogin, BuildContext ctx) async {
    UserCredential authResult;

    try {
      setState(() {
        isLoading = true;
      });
      if(isLogin){
        authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance.collection('users').doc(authResult.user?.uid).set({
          'nickName': nickName,
          'email': email,
        });
      }
    } on PlatformException catch (err) {
      String? message = 'An error occured, please check your credentials!';
      if(err.message != null) message = err.message;

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message!),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      setState(() {isLoading = false;});
    } catch (err) {
      setState(() {isLoading = false;});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AuthFormWidget(submitAuthForm, isLoading)
    );
  }
}
