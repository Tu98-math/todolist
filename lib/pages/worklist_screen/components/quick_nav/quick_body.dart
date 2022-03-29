import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

class QuickBody extends StatefulWidget {
  const QuickBody({Key? key}) : super(key: key);

  @override
  _QuickBodyState createState() => _QuickBodyState();
}

class _QuickBodyState extends State<QuickBody> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User? user;

  void getUid() async {
    // ignore: await_only_futures
    User u = await _auth.currentUser!;
    setState(() {
      user = u;
    });
  }

  @override
  void initState() {
    getUid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (user != null)
              Container(
                height: size.height * .7,
                width: size.width,
                child: StreamBuilder(
                  stream: users
                      .doc(user!.uid)
                      .collection('quick_note')
                      .orderBy('time')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return data['list'] == false
                              ? data['status'] == 0 ? QuickNoteCard(
                                  note: data['task'],
                                  color: AppColors.kColorNote[data['color']],
                                  id: document.id,
                                  uid: user!.uid,
                                ) : SizedBox()
                              : data['status'] == 0 ? ListQuickNoteCard(
                                  note: data['task'],
                                  color: AppColors.kColorNote[data['color']],
                                  listNote: [
                                    for (int i = 0; i < data['length']; i++)
                                      data['item$i'],
                                  ],
                                  checkListNote: [
                                    for (int i = 0; i < data['length']; i++)
                                      data['checked$i'],
                                  ],
                                  press: (index) => {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user!.uid)
                                        .collection("quick_note")
                                        .doc(document.id)
                                        .update({
                                      'checked$index': true,
                                    })
                                  },
                                  id: document.id,
                                  uid: user!.uid,
                                ) : SizedBox();
                        }).toList(),
                      );
                    }
                    return Container(
                      color: Colors.white,
                      child: Center(
                        child: Image.asset("assets/images/loader.gif"),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "Quick Notes",
        style: TextStyle(
          fontFamily: 'AvenirNextRoundedPro',
          fontWeight: FontWeight.bold,
          color: AppColors.kTextColor,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}

class QuickNoteCard extends StatelessWidget {
  const QuickNoteCard({
    Key? key,
    required this.note,
    required this.color,
    required this.id,
    required this.uid,
  }) : super(key: key);

  final String note, id, uid;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.kBoxShadow,
              offset: Offset(5, 9),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Row(
                children: [
                  Container(
                    width: 121,
                    height: 3,
                    color: color,
                  ),
                  Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 21,
                left: 32,
              ),
              child: Row(
                children: [
                  Container(
                    width: size.width * .7,
                    child: Text(
                      note,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 30 / 16,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        // FirebaseFirestore
                        // .instance
                        // .collection('users')
                        // .doc(uid)
                        // .collection("quick_note")
                        // .doc(id).delete();
                        showAlertDialog(context, uid, id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: AppColors.kPrimaryColor,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String uid, String id) {
    // set up the buttons
    Widget noButton = InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("NO"),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
    Widget yesButton = InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "YES",
        ),
      ),
      onTap: () {
        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection("quick_note")
            .doc(id)
            .update({
              'status': 1
            });
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Comple".toUpperCase(),
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text("Do you want to comple the task?"),
      actions: [
        noButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class ListQuickNoteCard extends StatelessWidget {
  const ListQuickNoteCard({
    Key? key,
    required this.note,
    required this.color,
    required this.listNote,
    required this.checkListNote,
    required this.press,
    required this.uid,
    required this.id,
  }) : super(key: key);

  final String note, uid, id;
  final Color color;
  final List<String> listNote;
  final List<bool> checkListNote;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.kBoxShadow,
              offset: Offset(5, 9),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Container(
                width: 121,
                height: 3,
                color: color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 21,
                left: 32,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        note,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 30 / 16,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            // FirebaseFirestore
                            // .instance
                            // .collection('users')
                            // .doc(uid)
                            // .collection("quick_note")
                            // .doc(id).delete();
                            showAlertDialog(context, uid, id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.kPrimaryColor,
                          ))
                    ],
                  ),
                  for (int i = 0; i < checkListNote.length; i++)
                    NoteIcon(
                      index: i,
                      text: listNote[i],
                      check: checkListNote[i],
                      press: press,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  InkWell NoteIcon(
      {required int index,
      required String text,
      required bool check,
      required Function press}) {
    return InkWell(
      onTap: () => press(index),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: check ? Color(0xFF979797) : Colors.white,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: Color(0xFF979797),
                ),
              ),
            ),
          ),
          SizedBox(width: 11),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              height: 30 / 16,
              fontWeight: FontWeight.w400,
              decoration:
                  check ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, String uid, String id) {
    // set up the buttons
    Widget noButton = InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("NO"),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
    Widget yesButton = InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "YES",
        ),
      ),
      onTap: () {
        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection("quick_note")
            .doc(id)
            .update({
              'status': 1
            });
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Comple".toUpperCase(),
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text("Do you want to comple the task?"),
      actions: [
        noButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
