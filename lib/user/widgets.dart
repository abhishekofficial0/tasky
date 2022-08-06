import 'package:flutter/material.dart';

Widget noTileAdmin(int no, String day, int type) {
  return Container(
    margin: EdgeInsets.only(left: 7.0, right: 7.0),
    child: Column(
      children: [
        Container(
          child: Text(
            day,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 6.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  color: type == 1
                      ? Colors.white
                      : type == 2
                          ? Colors.white
                          : Colors.pink.shade600,
                  width: type == 3
                      ? 2.0
                      : type == 2
                          ? 1.0
                          : 1.0),
              color: type == 1
                  ? Colors.pink.shade600
                  : type == 2
                      ? Colors.grey.shade200
                      : Colors.white,
              borderRadius: BorderRadius.circular(8.0)),
          height: 50.0,
          width: 40.0,
          child: Text(
            no.toString(),
            style: TextStyle(
                color: type == 1
                    ? Colors.white
                    : type == 2
                        ? Colors.grey
                        : Colors.pink.shade600,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}

Widget noTile(int no, bool type) {
  return Container(
    margin: EdgeInsets.only(top: 40.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: type ? Colors.pink.shade600 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.0)),
    height: 50.0,
    width: 40.0,
    child: Text(
      no.toString(),
      style: TextStyle(
          color: type ? Colors.white : Colors.grey,
          fontSize: 20.0,
          fontWeight: FontWeight.w500),
    ),
  );
}

Widget weekTile(int week) {
  return Container(
    height: 50.0,
    width: 100.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Color.fromARGB(228, 225, 190, 231),
        borderRadius: BorderRadius.circular(5.0)),
    child: Text(
      "Week " + week.toString(),
      style: TextStyle(
          color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w500),
    ),
  );
}

Widget monthTile(BuildContext context, String month) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.width / 10,
        left: 10.0,
        right: MediaQuery.of(context).size.width / 3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            month,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            weekTile(1),
            weekTile(2),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            weekTile(3),
            weekTile(4),
          ],
        )
      ],
    ),
  );
}

class DropDownAll extends StatefulWidget {
  DropDownAll(
      {required this.height,
      required this.width,
      required this.items,
      required this.dropdownvalue});

  int height;
  int width;
  List<String> items;
  String dropdownvalue;
  @override
  State<DropDownAll> createState() => _DropDownAllState();
}

class _DropDownAllState extends State<DropDownAll> {
  @override
  Widget build(BuildContext context) {
    String firstV = widget.items.first;

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: widget.height * 0.01),
      padding: EdgeInsets.only(
        right: widget.width * 0.03,
        left: widget.width * 0.04,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300)),
      height: widget.height * 0.07,
      width: (widget.width * 0.95),
      child: DropdownButton(
        value: widget.dropdownvalue,
        style: TextStyle(color: Colors.black),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        focusColor: Colors.grey.shade200,
        underline: Container(),
        items: widget.items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            widget.dropdownvalue = newValue!;
          });
        },
      ),
    );
  }
}

Widget detailsPageButton(BuildContext context, String name, bool enabled) {
  return GestureDetector(
      onTap: () {},
      child: Container(
          height: 50.0,
          width: 100.0,
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: enabled
                  ? Color.fromARGB(255, 58, 14, 116)
                  : Color.fromARGB(228, 225, 190, 231)),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          )));
}

class DropDownAllDetailsPage extends StatefulWidget {
  DropDownAllDetailsPage(
      {required this.height,
      required this.width,
      required this.items,
      required this.dropdownvalue});

  int height;
  int width;
  List<String> items;
  String dropdownvalue;
  @override
  State<DropDownAllDetailsPage> createState() => _DropDownAllDetailsPageState();
}

class _DropDownAllDetailsPageState extends State<DropDownAllDetailsPage> {
  @override
  Widget build(BuildContext context) {
    String firstV = widget.items.first;

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: widget.height * 0.01,
      ),
      padding: EdgeInsets.only(
        right: widget.width * 0.03,
        left: widget.width * 0.04,
      ),
      height: widget.height * 0.07,
      width: (widget.width * 0.55),
      child: DropdownButton(
        value: widget.dropdownvalue,
        style: TextStyle(color: Colors.black, fontSize: 18),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        focusColor: Colors.grey.shade200,
        underline: Container(),
        items: widget.items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            widget.dropdownvalue = newValue!;
          });
        },
      ),
    );
  }
}

Widget departmentBox(BuildContext context, String name) {
  return Container(
    margin: EdgeInsets.all(10.0),
    alignment: Alignment.center,
    height: 80.0,
    width: MediaQuery.of(context).size.width / 2 - 30,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          offset: const Offset(
            0.0,
            3.0,
          ),
          blurRadius: 1.0,
          spreadRadius: 0.5,
        ), //BoxShadow
        BoxShadow(
          color: Colors.white,
          offset: const Offset(0.0, 0.0),
          blurRadius: 0.0,
          spreadRadius: 0.0,
        ), //BoxShadow
      ],
    ),
    child: Text(
      name,
      style: TextStyle(
          color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
    ),
  );
}
