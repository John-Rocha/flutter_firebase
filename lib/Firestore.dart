import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  final String documentId;
  MyApp(this.documentId);
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Alguma coisa deu errado");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return CircularProgressIndicator();
            }
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document.data()['fullName']),
                  subtitle: new Text(document.data()['company']),
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
