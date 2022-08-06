import 'package:flutter/material.dart';
import 'package:task_app/user/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Stats extends StatefulWidget {
  Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Stats", textAlign: TextAlign.left),
        backgroundColor: Color.fromARGB(255, 66, 14, 134),
      ),
      body: Column(children: <Widget>[
        Container(
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
        Expanded(
          child: ListView.builder(
              //physics: ScrollableScrollPhysics(),
              //shrinkWrap: true,
              itemCount: 18,
              itemBuilder: (context, index) {
                return Container();
                // return DetailsDayStatusStats(
                //     date: "15th", title: "front-end", status: 3, id: "");
              }),
        ),
      ]),
    );
  }
}

class DetailsDayStatusStats extends StatefulWidget {
  DetailsDayStatusStats(
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
  State<DetailsDayStatusStats> createState() => _DetailsDayStatusStatsState();
}

class _DetailsDayStatusStatsState extends State<DetailsDayStatusStats> {
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(15.0),
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Text(
                                  widget.date,
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
                            height: 100.0,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('Tasks')
                                        .doc(widget.id)
                                        .update({"status": "2"}).then((value) =>
                                            {
                                              ScaffoldMessenger.of(context)
                                                ..removeCurrentSnackBar()
                                                ..showSnackBar(SnackBar(
                                                  content:
                                                      Text("Task Updated !!!"),
                                                )),
                                              Navigator.of(context).pop()
                                            });
                                  },
                                  child: Center(
                                    child: Container(
                                        height: 50.0,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                20,
                                        margin: EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 66, 14, 134),
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection('Tasks')
                                      .doc(widget.id)
                                      .update({"status": "1"}).then((value) => {
                                            ScaffoldMessenger.of(context)
                                              ..removeCurrentSnackBar()
                                              ..showSnackBar(SnackBar(
                                                content:
                                                    Text("Task Updated !!!"),
                                              )),
                                            Navigator.of(context).pop()
                                          });
                                },
                                child: Center(
                                  child: Container(
                                      height: 50.0,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          20,
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
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
                        ],
                      ),
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
