import 'package:flutter/material.dart';
import 'package:task_app/user/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamMember extends StatefulWidget {
  TeamMember({required this.department});

  String department;

  @override
  State<TeamMember> createState() => _TeamMemberState();
}

class _TeamMemberState extends State<TeamMember> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Pending for approval", textAlign: TextAlign.left),
        backgroundColor: Color.fromARGB(255, 66, 14, 134),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 25.0, top: 15.0, left: 10.0),
            child: Row(
              children: [
                DropDownAllDetailsPage(
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
                Spacer(),
                GestureDetector(
                  onTap: (() {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Stats()));
                    setState(() {
                      selected = !selected;
                    });
                  }),
                  child: Text(
                    selected ? "select all" : "select",
                    style: TextStyle(
                        color: Color.fromARGB(255, 66, 14, 134),
                        decoration: TextDecoration.underline,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('Tasks')
                .where("department", isEqualTo: widget.department)
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
                      String id = docs[index].id;
                      return GestureDetector(
                        onTap: (() {
                          print("Hurry tapped");
                        }),
                        child: MultiSelectList(
                          date: docs[index]["created"],
                          title: docs[index]["title"],
                          status: int.parse(docs[index]["status"]),
                          task: docs[index],
                          id: id,
                          selected: selected,
                        ),
                      );
                    });
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 66, 14, 134),
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Approve",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        )),
                  )),
              GestureDetector(
                onTap: () {},
                child: Center(
                  child: Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Decline",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          )
        ],
      )),
    );
  }
}

class DetailsDayStatusMember extends StatefulWidget {
  DetailsDayStatusMember(
      {required this.date, required this.title, required this.status});

  String date;
  String title;
  int status;

  @override
  State<DetailsDayStatusMember> createState() => _DetailsDayStatusMemberState();
}

class _DetailsDayStatusMemberState extends State<DetailsDayStatusMember> {
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
          Container(
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
                                color: Color.fromARGB(255, 66, 14, 134)),
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
          ),
        ],
      ),
    );
  }
}

class MultiSelectList extends StatefulWidget {
  MultiSelectList(
      {required this.date,
      required this.title,
      required this.status,
      required this.task,
      required this.selected,
      required this.id});

  String date;
  String title;
  int status;
  String id;
  bool selected;
  QueryDocumentSnapshot<Map<String, dynamic>> task;

  @override
  State<MultiSelectList> createState() => _MultiSelectListState();
}

class _MultiSelectListState extends State<MultiSelectList> {
  // bool isSelected = widget.selected;
  List<String> idSelected = [];
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: widget.selected
              ? Border.all(color: const Color.fromARGB(255, 66, 14, 134))
              : null,
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey.shade100,
        ),
        height: 80.0,
        width: MediaQuery.of(context).size.width.toInt() - 20,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
            Widget>[
          widget.selected
              ? Checkbox(
                  checkColor: Colors.white,
                  activeColor: const Color.fromARGB(255, 66, 14, 134),
                  value: value,
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  })
              : Container(),
          Text(widget.date.toString(), style: TextStyle(fontSize: 18.0)),
          Text(widget.task["user_name"],
              style: const TextStyle(fontSize: 16.0, color: Colors.grey)),
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
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Container(
                                    margin: const EdgeInsets.all(15.0),
                                    alignment: Alignment.topLeft,
                                    child: Row(children: [
                                      Text(widget.date,
                                          style: const TextStyle(fontSize: 20)),
                                      const Spacer(),
                                      GestureDetector(
                                          onTap: (() =>
                                              Navigator.of(context).pop()),
                                          child: const Icon(Icons.close,
                                              color: Colors.black))
                                    ])),
                                Container(
                                    margin: const EdgeInsets.all(15.0),
                                    child: Text(
                                        widget.task["assigned_by"] +
                                            " - " +
                                            widget.task["department"],
                                        style: const TextStyle(
                                            fontSize: 25,
                                            color: Color.fromARGB(
                                                255, 76, 16, 154)))),
                                Container(
                                    margin: const EdgeInsets.all(15.0),
                                    child: Text(
                                        "Assigned By - ${widget.task["user_name"]}",
                                        style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                        ))),
                                Container(
                                    margin: const EdgeInsets.all(15.0),
                                    child: Text("Updates:",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.grey.shade700,
                                        ))),
                                Container(
                                    margin: const EdgeInsets.all(15.0),
                                    child: Text(widget.task["update"],
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.black))),
                                const SizedBox(height: 100.0),
                                Row(children: [
                                  GestureDetector(
                                      onTap: () {
                                        FirebaseFirestore.instance
                                            .collection('Tasks')
                                            .doc(widget.id)
                                            .update({
                                          "status": "2"
                                        }).then((value) => {
                                                  ScaffoldMessenger.of(context)
                                                    ..removeCurrentSnackBar()
                                                    ..showSnackBar(
                                                        const SnackBar(
                                                      content: Text(
                                                          "Task Updated !!!"),
                                                    )),
                                                  Navigator.of(context).pop()
                                                });
                                      },
                                      child: Center(
                                          child: Container(
                                              height: 50.0,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  20,
                                              margin: const EdgeInsets.only(
                                                  left: 10.0, right: 10.0),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 66, 14, 134),
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Center(
                                                  child: Text("Approve",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20)))))),
                                  GestureDetector(
                                      onTap: () {
                                        FirebaseFirestore.instance
                                            .collection('Tasks')
                                            .doc(widget.id)
                                            .update({
                                          "status": "1"
                                        }).then((value) => {
                                                  ScaffoldMessenger.of(context)
                                                    ..removeCurrentSnackBar()
                                                    ..showSnackBar(
                                                        const SnackBar(
                                                      content: Text(
                                                          "Task Updated !!!"),
                                                    )),
                                                  Navigator.of(context).pop()
                                                });
                                      },
                                      child: Center(
                                          child: Container(
                                              height: 50.0,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  20,
                                              margin: const EdgeInsets.only(
                                                  left: 10.0, right: 10.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Center(
                                                  child: Text("Decline",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                      ))))))
                                ])
                              ])));
                    });
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 76, 16, 154),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: widget.status == 1
                      ? const Icon(
                          Icons.close,
                          color: Colors.white,
                        )
                      : widget.status == 2
                          ? const Icon(
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
                                      color: const Color.fromARGB(
                                          255, 76, 16, 154)),
                                  borderRadius: BorderRadius.circular(20.0)),
                            )))
        ]));
  }
}
