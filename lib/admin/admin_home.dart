import 'package:flutter/material.dart';
import 'package:task_app/admin/Approval.dart';
import 'package:task_app/admin/department_page.dart';
import 'package:task_app/authentication/pages/login.dart';
import 'package:task_app/authentication/viewmodel/authentication_view_model.dart';
import 'package:task_app/user/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHome extends StatefulWidget {
  AdminHome({Key? key, required this.user}) : super(key: key);

  QueryDocumentSnapshot<Map<String, dynamic>> user;

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Hi ${widget.user["username"]}", textAlign: TextAlign.left),
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
          child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 10.0, top: 10.0),
              height: 40.0,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white),
              alignment: Alignment.topLeft,
              child: DropDownAllDetailsPage(
                dropdownvalue: "July 2022",
                items: const [
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
          const SizedBox(height: 10.0),
          GestureDetector(
              onTap: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Approval()));
              }),
              child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15.0),
                  margin: const EdgeInsets.only(left: 10, right: 20.0),
                  height: 80.0,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: const [
                    Text(
                      "Pending for Approval",
                      style: TextStyle(
                          color: Color.fromARGB(255, 72, 13, 148),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                  ]))),
          const SizedBox(height: 30.0),
          const Text(
            "Departments",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20.0),
          Wrap(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DepartmentPage(department: "Technical")));
                  },
                  child: departmentBox(context, "Technical")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DepartmentPage(department: "Design")));
                  },
                  child: departmentBox(context, "Design")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DepartmentPage(department: "Accounts")));
                  },
                  child: departmentBox(context, "Accounts")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DepartmentPage(department: "Marketing")));
                  },
                  child: departmentBox(context, "Marketing")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DepartmentPage(department: "Logistics")));
                  },
                  child: departmentBox(context, "Logistics")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DepartmentPage(department: "Resigination")));
                  },
                  child: departmentBox(context, "Resigination")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DepartmentPage(department: "Media")));
                  },
                  child: departmentBox(context, "Media")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DepartmentPage(department: "Documentation")));
                  },
                  child: departmentBox(context, "Documentation")),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
        ]),
      )),
    );
  }
}
