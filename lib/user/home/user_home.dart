import 'package:flutter/material.dart';
import 'package:task_app/authentication/pages/login.dart';
import 'package:task_app/authentication/viewmodel/authentication_view_model.dart';
import 'package:task_app/user/home/home.dart';
import 'package:task_app/user/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserHome extends StatefulWidget {
  UserHome({required this.user});

  QueryDocumentSnapshot<Map<String, dynamic>> user;

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Hi ${widget.user['username']}", textAlign: TextAlign.left),
        backgroundColor: const Color.fromARGB(255, 76, 16, 154),
        actions: [
          TextButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                await AuthenticationViewModel().signOut();
                navigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false);
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 10.0, top: 10.0),
              height: 40.0,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0), color: Colors.pink),
              alignment: Alignment.topLeft,
              child: DropDownAllDetailsPage(
                dropdownvalue: "July 2022",
                items: [
                  "January 2022",
                  "February 2022",
                  "March 2022",
                  "April 2022",
                  "May 2022",
                  "June 2022",
                  "July 2022",
                  "august 2022",
                  "September 2022",
                  "August 2022",
                  "October 2022",
                  "November 2022",
                  "December 2022",
                ],
                height: MediaQuery.of(context).size.height.toInt(),
                width: MediaQuery.of(context).size.width.toInt(),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('Tasks')
                .where("user_id", isEqualTo: widget.user["user_id"])
                .snapshots(),
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
                      String da = docs[index].id;
                      return DetailsDayStatus(
                          date: docs[index]["created"],
                          title: docs[index]["title"],
                          status: int.parse(docs[index]["status"]),
                          task: docs[index],
                          id: da);
                    });
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(user: widget.user)));
            },
            child: Container(
                height: 50.0,
                width: 180.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 58, 14, 116)),
                child: Center(
                  child: Text(
                    "Add Updates",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )),
          ),
        ],
      )),
    );
  }
}

class DetailsDayStatus extends StatefulWidget {
  DetailsDayStatus(
      {required this.date,
      required this.title,
      required this.status,
      required this.task,
      required this.id});

  String date;
  String title;
  int status;
  String id;
  QueryDocumentSnapshot<Map<String, dynamic>> task;

  @override
  State<DetailsDayStatus> createState() => _DetailsDayStatusState();
}

class _DetailsDayStatusState extends State<DetailsDayStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey.shade100,
      ),
      height: 80.0,
      width: MediaQuery.of(context).size.width.toInt() - 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(widget.date.toString(), style: TextStyle(fontSize: 18.0)),
          Text(widget.title.toString(),
              style: TextStyle(fontSize: 16.0, color: Colors.grey)),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                barrierColor: Colors.grey,
                elevation: 20,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(15.0),
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Text(
                                widget.task["created"],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: (() => Navigator.of(context).pop()),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          child: Text(
                            widget.task["user_name"] +
                                " - " +
                                widget.task["department"],
                            style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 76, 16, 154),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          child: Text(
                            "Assigned By - " + widget.task["assigned_by"],
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          child: Text(
                            "Updates:",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          child: Text(
                            widget.task["update"],
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        GestureDetector(
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection('Tasks')
                                  .doc(widget.id)
                                  .delete()
                                  .then((value) => {
                                        ScaffoldMessenger.of(context)
                                          ..removeCurrentSnackBar()
                                          ..showSnackBar(SnackBar(
                                            content: Text("Task Deleted !!!"),
                                          )),
                                        Navigator.of(context).pop()
                                      });
                            },
                            child: Center(
                              child: Container(
                                  height: 50.0,
                                  width: 200.0,
                                  margin:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                      ),
                                    ),
                                  )),
                            )),
                        SizedBox(
                          height: 50.0,
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 76, 16, 154),
                  borderRadius: BorderRadius.circular(20.0)),
              child: widget.status == 1
                  ? Icon(
                      Icons.close,
                      color: Colors.white,
                    )
                  : widget.status == 2
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: Colors.white,
                        )
                      : Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 2.0,
                                  color: Color.fromARGB(255, 76, 16, 154)),
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
