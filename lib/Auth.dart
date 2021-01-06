import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: "john@gmail.com", password: "12345678");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("A senha é muito fraca");
      } else if (e.code == 'email-already-in-use') {
        print("A conta já existe para este e-mail");
      }
    } catch (e) {
      print(e);
    }
  }

  _userState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser.email + " e " + auth.currentUser.uid);
    } else {
      print("Ninguém conectado");
    }
  }

  _signOut() async {
    await _auth.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_signUp();
    _userState();
    _signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
