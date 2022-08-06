import 'package:flutter/material.dart';
import 'package:task_app/admin/stats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Approval extends StatefulWidget {
  // Approval({required this.user});

  // QueryDocumentSnapshot<Map<String, dynamic>> user;

  @override
  State<Approval> createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Pending Approval", textAlign: TextAlign.left),
        backgroundColor: Colors.pink.shade600,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('Tasks').snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;

            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final docs = snapshot.data!.docs;
                  String id = docs[index].id;
                  return DetailsDayStatusStats(
                    date: docs[index]["created"],
                    title: docs[index]["title"],
                    status: int.parse(docs[index]["status"]),
                    task: docs[index],
                    id: id,
                  );
                });
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
