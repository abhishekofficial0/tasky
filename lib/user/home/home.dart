import 'package:flutter/material.dart';
import 'package:task_app/user/home/user_home.dart';
import 'package:task_app/user/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Home extends StatefulWidget {
  Home({required this.user});

  QueryDocumentSnapshot<Map<String, dynamic>> user;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String getDate() {
    DateTime today = new DateTime.now();
    var _today = DateTime.parse(today.toString());
    String _formatToday =
        DateFormat.yMMMMd().format(today).replaceAll(",", " ");
    return _formatToday;
  }

  DateTime? selectedDate;

  TextEditingController assigned_byController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController updatesController = TextEditingController();

  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // using state so that the UI will be rerendered when date is picked
        selectedDate = pickedDate;
        selectedDate = DateFormat.yMMMMd().format(selectedDate!) as DateTime?;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int height = (MediaQuery.of(context).size.height).toInt();
    int width = (MediaQuery.of(context).size.width).toInt();
    Uuid uuid = new Uuid();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Hi " + widget.user['username'], textAlign: TextAlign.left),
        backgroundColor: Color.fromARGB(255, 76, 16, 154),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     SizedBox(
            //       width: 10.0,
            //     ),
            // noTile(9, true),
            // noTile(8, false),
            // noTile(7, false),
            GestureDetector(
              onTap: (() {
                _presentDatePicker();
              }),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  alignment: Alignment.center,
                  height: 30.0,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(5.0)),
                  margin: EdgeInsets.only(left: 10.0, top: 40.0, bottom: 20.0),
                  child: Text(
                    selectedDate != null
                        ? DateFormat.yMMMMd().format(selectedDate!).toString()
                        : getDate(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            //     SizedBox(
            //       width: 20.0,
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 30.0,
            // ),
            DropDownAll(
                height: height,
                width: width,
                items: [
                  "Technical",
                  "Marketing",
                  "Accounts",
                  "Design",
                  "Logistics",
                  "Registration",
                  "Media",
                  "Documnetation"
                ],
                dropdownvalue: widget.user["department"]),
            Container(
                padding: EdgeInsets.only(left: 10.0, top: 3, bottom: 3.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)),
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                    controller: assigned_byController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Assigned by',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 18.0)))),
            Container(
                padding: EdgeInsets.only(left: 10.0, top: 3, bottom: 3.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)),
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 18.0)))),
            Container(
                padding: EdgeInsets.only(left: 10.0, top: 3, bottom: 3.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)),
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                    maxLines: 6,
                    controller: updatesController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Updates',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 18.0)))),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                var uid = uuid.v1();
                FirebaseFirestore.instance.collection("Tasks").add({
                  "task_id": uid,
                  "user_id": widget.user['user_id'],
                  "role": widget.user['role'],
                  "created": selectedDate != null
                      ? DateFormat.yMMMMd().format(selectedDate!).toString()
                      : getDate(),
                  "department": widget.user['department'],
                  "assigned_by": assigned_byController.text,
                  "title": titleController.text,
                  "update": updatesController.text,
                  "status": "0",
                  "user_name": widget.user['username']
                }).then((value) {
                  print("Database Return Id:" + value.id);
                  titleController.text = "";
                  updatesController.text = "";
                  assigned_byController.text = "";
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text("Task Uploaded 🥳🥳🥳"),
                    ));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserHome(user: widget.user)));
                });
              },
              child: Container(
                  height: 50.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 58, 14, 116)),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )),
            ),
            //monthTile(context, "September 2022"),
            //   monthTile(context, "August 2022"),
            //   monthTile(context, "October 2022"),
          ],
        ),
      ),
    );
  }
}
