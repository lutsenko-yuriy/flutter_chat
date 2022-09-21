import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
      String email, String password, String username, bool signup) async {

    setState(() {
      _isLoading = true;
    });

    UserCredential authResult;

    try {
      if (signup) {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set({'username': username, 'email': email});
      } else {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } on FirebaseAuthException catch (err) {
      var message = 'An error occurred. Please check your credentials.';

      if (err.message != null) {
        message = err.message!;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (err) {
      print(err);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitAuthForm: _submitAuthForm, isLoading: _isLoading),
    );
  }
}
