import 'package:flutter/material.dart';
import 'package:task_app/admin/stats.dart';
import 'package:task_app/admin/team_member.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentPage extends StatefulWidget {
  DepartmentPage({required this.department});
  String department;
  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(widget.department, textAlign: TextAlign.left),
          backgroundColor: Color.fromARGB(255, 76, 16, 154),
        ),
        body: Container(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TeamMember(
                                department: widget.department,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15.0),
                  margin: EdgeInsets.only(left: 10, right: 20.0, top: 30.0),
                  height: 80.0,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Text(
                        "Pending for Approval",
                        style: TextStyle(
                            color: Color.fromARGB(255, 72, 13, 148),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      // Container(
                      //   //margin: EdgeInsets.only(top: 40.0),
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //       color: Color.fromARGB(255, 76, 16, 154),
                      //       borderRadius: BorderRadius.circular(8.0)),
                      //   height: 50.0,
                      //   width: 40.0,
                      //   child: Text(
                      //     "15",
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 20.0,
                      //         fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, bottom: 20.0, top: 30.0),
                child: Text(
                  "Team:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .where("department", isEqualTo: widget.department)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError)
                    return Text('Error = ${snapshot.error}');

                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;

                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final docs = snapshot.data!.docs;
                          String id = docs[index].id;
                          return departmentMembersCards(
                              context, docs[index]["username"]);
                        });
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          )),
        ));
  }
}

Widget departmentMembersCards(BuildContext context, String name) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 15, right: 15.0),
    margin: EdgeInsets.only(left: 30, right: 20.0, top: 10.0),
    height: 60.0,
    width: MediaQuery.of(context).size.width - 50,
    decoration: BoxDecoration(
        color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
    child: Text(
      name,
      style: TextStyle(
          color: Color.fromARGB(255, 91, 57, 135),
          fontSize: 20.0,
          fontWeight: FontWeight.w500),
    ),
  );
}
