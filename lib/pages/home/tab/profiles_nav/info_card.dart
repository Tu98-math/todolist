import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/routing/app_routes.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class InfoCard extends StatefulWidget {
  const InfoCard({
    Key? key,
  }) : super(key: key);

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  String link = '';
  final ImagePicker _picker = ImagePicker();
  final String? _email = FirebaseAuth.instance.currentUser!.email;
  final String? _name = FirebaseAuth.instance.currentUser!.displayName;
  final User? user = FirebaseAuth.instance.currentUser;
  bool _noneAvatar = true;
  int _createTask = 0;
  int _completedTask = 0;

  Future<void> loadTask() async {
    // quick note length
    int completed = 0;
    int taskLength = 0;
    await FirebaseFirestore.instance.collection('project').get().then((snap) {
      for (int i = 0; i < snap.docs.length; i++) {
        final listID = snap.docs.asMap()[i]!['member'];
        listID.add(snap.docs.asMap()[i]!['for']);
        if (listID.contains(user!.uid)) {
          taskLength++;
          if (snap.docs.asMap()[i]!['status'] == 1) {
            completed++;
          }
        }
      } // will return the collection size
    });
    setState(() {
      _createTask = taskLength;
      _completedTask = completed;
    });
  }

  void checkAvatar() {
    if (user != null)
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        bool _checkNoneAvatar;
        if (documentSnapshot.get('avatar') != '' && _noneAvatar == true)
          _checkNoneAvatar = true;
        else
          _checkNoneAvatar = false;
        setState(() {
          _noneAvatar = _checkNoneAvatar;
        });
      });
  }

  void takePhoto(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile!.path != '') {
      uploadFile(pickedFile.path);
      loadAvatar();
      checkAvatar();
    }
  }

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('users/avatar/${user!.uid}.png')
          .putFile(file);
      loadAvatar();
      checkAvatar();
      // ignore: unused_catch_clause
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> loadAvatar() async {
    String _link = await firebase_storage.FirebaseStorage.instance
        .ref('users/avatar/${user!.uid}.png')
        .getDownloadURL();
    if (link != _link) {
      setState(() {
        link = _link;
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({'avatar': _link});
      loadAvatar();
      checkAvatar();
    }
  }

  @override
  void initState() {
    loadAvatar();
    loadTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    checkAvatar();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(10),
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 10),
              blurRadius: 3,
              color: AppColors.kBoxShadow,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 14.0,
                    left: 14,
                  ),
                  child: Container(
                    width: size.width * .15,
                    height: size.width * .15,
                    child: Stack(
                      children: <Widget>[
                        _noneAvatar
                            ? link != ''
                                ? CircleAvatar(
                                    radius: 80.0,
                                    backgroundImage: NetworkImage(
                                      '$link',
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 80.0,
                                    backgroundImage: AssetImage(
                                      "assets/images/loader.gif",
                                    ),
                                  )
                            : CircleAvatar(
                                radius: 80.0,
                                backgroundImage: AssetImage(
                                  "assets/images/none-avatar.png",
                                ),
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              showBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet(context)),
                              );
                            },
                            child: Icon(
                              Icons.camera_alt,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CompoText(
                    title: "$_name",
                    content: "$_email",
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, AppRoutes.logInRoute);
                  },
                  icon: Icon(
                    Icons.logout,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(27),
              child: Row(
                children: [
                  CompoText(
                    title: _createTask.toString(),
                    content: "Create Tasks",
                  ),
                  Spacer(),
                  CompoText(
                    title: _completedTask.toString(),
                    content: "Completed Tasks",
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 160,
      width: size.width,
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              "Choose Profile photo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        takePhoto(ImageSource.camera);
                      },
                      icon: Icon(Icons.camera),
                    ),
                    Text("Camera"),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        takePhoto(ImageSource.gallery);
                      },
                      icon: Icon(Icons.image),
                    ),
                    Text("Gallery"),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CompoText extends StatelessWidget {
  const CompoText({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title, content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'AvenirNextRoundedPro',
        ),
        children: [
          TextSpan(
            text: "$title\n",
            style: TextStyle(
              color: AppColors.kTextColor,
            ),
          ),
          TextSpan(
            text: content.length <= 15
                ? content
                : content.substring(0, 14) + '...',
            style: TextStyle(
              color: Color(0xFF9A9A9A),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
