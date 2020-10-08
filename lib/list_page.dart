import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'authentication_service.dart';


class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Scaffold(
          appBar: AppBar(title: Text('MENÚ')),
          body: StreamBuilder(
            stream: Firestore.instance.collection('menu').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }
              List<DocumentSnapshot> docs = snapshot.data.documents;
              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = docs[index].data();
                    return ListTile(
                      title: Text(data['nombre']),
                      subtitle: Text(String.fromCharCode(36) + data['precio'].toString()),
                    );
                  }
              );
            },
          ),
          floatingActionButton: RaisedButton(
            onPressed: (){
              context.read<AuthenticationService>().signOut();
            },
            child: Text('Log out'),
          ),
        ),
      ),

    );
  }
}

