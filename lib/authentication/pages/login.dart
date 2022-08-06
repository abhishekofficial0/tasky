import 'package:flutter/material.dart';
import 'package:task_app/admin/admin_home.dart';

import 'package:task_app/user/home/home.dart';
import 'package:task_app/user/home/user_home.dart';
import 'package:task_app/user/splash_screen.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:email_validator/email_validator.dart';
import '../viewmodel/authentication_view_model.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isAdmin = true;
  bool isLogIn = true;
  final GlobalKey<FormState> formKey = GlobalKey();
  UserCredential? userCredential;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  Uuid uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0.0),
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Form(
                    key: formKey,
                    child: Column(children: [
                      const Text(
                        "Welcome!",
                        style: TextStyle(
                            fontSize: 35.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400)),
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.shade400)),
                                    child: Row(children: <Widget>[
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isAdmin == false) {
                                                setState(() {
                                                  isAdmin = true;
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.85 /
                                                      2 -
                                                  2,
                                              color: isAdmin == true
                                                  ? const Color.fromARGB(
                                                      255, 58, 14, 116)
                                                  : Colors.white,
                                              child: Center(
                                                  child: Text(
                                                "Admin",
                                                style: TextStyle(
                                                    color: isAdmin == true
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 20),
                                              )))),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isAdmin == true) {
                                                setState(() {
                                                  isAdmin = false;
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                              color: isAdmin == false
                                                  ? const Color.fromARGB(
                                                      255, 58, 14, 116)
                                                  : Colors.white,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.85 /
                                                      2 -
                                                  2,
                                              child: Center(
                                                  child: Text(
                                                "User",
                                                style: TextStyle(
                                                    color: isAdmin == false
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 20),
                                              ))))
                                    ])),

                                /// Now for the 2 Text Boxes
                                !isLogIn
                                    ? Container(
                                        margin: const EdgeInsets.all(10.0),
                                        child: TextFormField(
                                            controller: userNameController,
                                            keyboardType: TextInputType.name,

                                            // validator: (name) =>
                                            //     !EmailValidator.validate(email!)
                                            //         ? 'Enter a valid email'
                                            //         : null,
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                border: InputBorder.none,
                                                hintText: 'UserName',
                                                fillColor: const Color.fromARGB(
                                                    255, 239, 237, 237),
                                                filled: true)))
                                    : Container(),
                                Container(
                                    margin: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        autofillHints: const [
                                          AutofillHints.email
                                        ],
                                        validator: (email) =>
                                            !EmailValidator.validate(email!)
                                                ? 'Enter a valid email'
                                                : null,
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            border: InputBorder.none,
                                            hintText: 'ID',
                                            fillColor: const Color.fromARGB(
                                                255, 239, 237, 237),
                                            filled: true))),
                                Container(
                                    margin: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                        controller: passwordController,
                                        obscureText: true,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            border: InputBorder.none,
                                            hintText: 'Password',
                                            fillColor: const Color.fromARGB(
                                                255, 239, 237, 237),
                                            filled: true))),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                        onTap: isLogIn
                                            ? () async {
                                                final form =
                                                    formKey.currentState;
                                                if (form!.validate()) {
                                                  try {
                                                    await AuthenticationViewModel()
                                                        .signIn(
                                                            emailController
                                                                .text,
                                                            passwordController
                                                                .text)
                                                        .then(
                                                      (value) async {
                                                        var item = FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .where("Email",
                                                                isEqualTo:
                                                                    emailController
                                                                        .text)
                                                            .get()
                                                            .then((value) => {
                                                                  if (isAdmin)
                                                                    {
                                                                      ScaffoldMessenger.of(
                                                                          context)
                                                                        ..removeCurrentSnackBar()
                                                                        ..showSnackBar(
                                                                            const SnackBar(
                                                                          content:
                                                                              Text("User Logged In"),
                                                                        )),
                                                                      Navigator.of(context).pushAndRemoveUntil(
                                                                          MaterialPageRoute(
                                                                              builder: (context) => AdminHome(
                                                                                    user: value.docs[0],
                                                                                  )),
                                                                          (Route<dynamic> route) => false),
                                                                    }
                                                                  else
                                                                    {
                                                                      Navigator.of(context).pushAndRemoveUntil(
                                                                          MaterialPageRoute(
                                                                              builder: (context) => UserHome(user: value.docs[0])),
                                                                          (Route<dynamic> route) => false),
                                                                    }
                                                                });
                                                      },
                                                    );
                                                  } on FirebaseAuthException catch (e) {
                                                    print("logged in error");
                                                    print(e);
                                                    if (e.code ==
                                                        'user-not-found') {
                                                      CoolAlert.show(
                                                          context: context,
                                                          type: CoolAlertType
                                                              .error,
                                                          text:
                                                              'No user found for that email.');
                                                    } else if (e.code ==
                                                        'wrong-password') {
                                                      CoolAlert.show(
                                                          context: context,
                                                          type: CoolAlertType
                                                              .error,
                                                          text:
                                                              'Wrong password provided for that user.');
                                                    }
                                                  }
                                                }
                                              }
                                            : () async {
                                                var uid = uuid.v1();
                                                await AuthenticationViewModel()
                                                    .signUpWithEmailAndPassword(
                                                        uid,
                                                        emailController.text,
                                                        passwordController.text)
                                                    .then((value) =>
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .add({
                                                          "user_id": uid,
                                                          "role": isAdmin
                                                              ? "admin"
                                                              : "user",
                                                          "Email":
                                                              emailController
                                                                  .text,
                                                          "department":
                                                              'Accounts',
                                                          "username":
                                                              userNameController
                                                                  .text,
                                                          "Password":
                                                              passwordController
                                                                  .text,
                                                          "token_id": value,
                                                        }).then(
                                                          (value) async {
                                                            var item = FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Users")
                                                                .where("Email",
                                                                    isEqualTo:
                                                                        emailController
                                                                            .text)
                                                                .get()
                                                                .then(
                                                                    (value) => {
                                                                          if (isAdmin)
                                                                            {
                                                                              ScaffoldMessenger.of(context)
                                                                                ..removeCurrentSnackBar()
                                                                                ..showSnackBar(const SnackBar(
                                                                                  content: Text("User Logged In"),
                                                                                )),
                                                                              Navigator.of(context).pushAndRemoveUntil(
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => AdminHome(
                                                                                            user: value.docs[0],
                                                                                          )),
                                                                                  (Route<dynamic> route) => false),
                                                                            }
                                                                          else
                                                                            {
                                                                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => UserHome(user: value.docs[0])), (Route<dynamic> route) => false),
                                                                            }
                                                                        });
                                                          },
                                                        ));
                                              },
                                        child: Container(
                                            height: 50.0,
                                            width: 100.0,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color.fromARGB(
                                                    255, 58, 14, 116)),
                                            child: Center(
                                                child: isLogIn
                                                    ? const Text("Log In",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20))
                                                    : const Text('Sign Up',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20))))),
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isLogIn = !isLogIn;
                                      });
                                    },
                                    child: isLogIn
                                        ? const Text("Sign Up Instead",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ))
                                        : const Text('Login Instead',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20))),
                                const SizedBox(height: 10),
                              ]))
                    ])))));
  }
}
