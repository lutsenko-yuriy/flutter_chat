import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  void _submitAuthForm(String email, String password, String username,
      File? image, bool signup) async {
    setState(() {
      _isLoading = true;
    });

    UserCredential authResult;

    try {
      if (signup) {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child("user_images")
            .child('${authResult.user!.uid}.jpg');

        String? imageUrl;
        if (image != null) {
          await ref.putFile(image).whenComplete(() {});

          imageUrl = await ref.getDownloadURL();
        }

        var dataToSend = {'username': username, 'email': email};

        if (imageUrl != null) {
          dataToSend['image_url'] = imageUrl;
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set(dataToSend);
      } else {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }

      setState(() {
        _isLoading = false;
      });
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
