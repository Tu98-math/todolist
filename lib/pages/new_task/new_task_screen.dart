import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/constants/images.dart';
import 'package:to_do_list/widgets/primary_button.dart';

import 'components/input_descripttion.dart';
import 'components/input_due_date.dart';
import 'components/input_due_time.dart';
import 'components/input_title.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  String link = '';
  String _projectValue = '', _projectId = '';
  bool disable = true;
  // ignore: avoid_init_to_null
  DateTime? _myDate = null;
  // ignore: avoid_init_to_null
  TimeOfDay? _myTime = null;

  List<String> member = [];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  void addMember(String uidMember) {
    setState(() {
      member.add(uidMember);
    });
  }

  void removeMember(String uidMember) {
    setState(() {
      member.remove(uidMember);
    });
  }

  void setDate(date) {
    setState(() {
      _myDate = date;
    });
  }

  void setTime(time) {
    setState(() {
      _myTime = time;
    });
  }

  void setProjectValue(String title, String id) {
    setState(() {
      _projectValue = title;
      _projectId = id;
    });
  }

  Future<void> loadAvatar() async {
    String _link = await firebase_storage.FirebaseStorage.instance
        .ref('users/avatar/${user!.uid}.png')
        .getDownloadURL();
    if (link != _link)
      setState(() {
        link = _link;
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    loadAvatar();
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            width: size.width,
            height: 44,
            child: Container(color: AppColors.kPrimaryColor),
          ),
          Positioned(
            top: 10,
            left: 0,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: size.height * .75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'For',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF4F4F4),
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Row(
                                    children: [
                                      link != ''
                                          ? CircleAvatar(
                                              radius: 25,
                                              backgroundImage: NetworkImage(
                                                '$link',
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 25,
                                              backgroundImage: AssetImage(
                                                "assets/images/none-avatar.png",
                                              ),
                                            ),
                                      SizedBox(width: 10),
                                      Text(
                                        user!.displayName
                                            .toString()
                                            .substring(0, 8),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                  'In',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: 90,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF4F4F4),
                                      borderRadius: BorderRadius.circular(40)),
                                  child: InkWell(
                                    onTap: () {
                                      openProjectDialog(user!, setProjectValue);
                                    },
                                    child: Center(
                                        child: Text(
                                      _projectValue == ''
                                          ? 'Project'
                                          : _projectValue,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InputTitle(
                        controller: _titleController,
                      ),
                      InputDescription(
                        controller: _descriptionController,
                      ),
                      InputDueDate(
                        date: _myDate,
                        press: setDate,
                      ),
                      InputDueTime(
                        time: _myTime,
                        press: setTime,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Member',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      List<QueryDocumentSnapshot<Object?>>
                                          data = snapshot.data!.docs;
                                      return Row(
                                        children: [
                                          for (int i = 0; i < data.length; i++)
                                            if (member.contains(data[i]['uid']))
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                child: Stack(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        data[i]['avatar'],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: InkWell(
                                                        onTap: () =>
                                                            removeMember(
                                                                data[i]['uid']),
                                                        child: Icon(
                                                          Icons.remove_circle,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                        ],
                                      );
                                    }
                                    return Container(
                                      color: Colors.white,
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/loader.gif",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  width: member.length == 0 ? 90 : 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF4F4F4),
                                      borderRadius: BorderRadius.circular(40)),
                                  child: InkWell(
                                    onTap: () {
                                      openMemberDialog(addMember, member);
                                    },
                                    child: Center(
                                        child: Text(
                                      member.length == 0 ? 'Anyone' : '+',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: PrimaryButton(
                          text: "Done",
                          disable: disable,
                          press: () async {
                            setState(() {
                              disable = false;
                            });
                            int sizeProject = 0;
                            await FirebaseFirestore.instance
                                .collection('project')
                                .get()
                                .then((snap) {
                              sizeProject = snap.docs
                                  .length; // will return the collection size
                            });
                            await FirebaseFirestore.instance
                                .collection('project')
                                .doc('${sizeProject + 1}')
                                .set({
                              'for': user!.uid,
                              'inID': _projectId,
                              'inName': _projectValue,
                              'title': _titleController.text.trim(),
                              'description': _descriptionController.text.trim(),
                              'date': _myDate.toString(),
                              'create': DateTime.now().toString(),
                              'time': '${_myTime!.hour}:${_myTime!.minute}',
                              'member': member,
                              'ID': sizeProject + 1,
                              'status': 0
                            });
                            int task = 0;
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid)
                                .collection('project')
                                .doc(_projectId)
                                .get()
                                .then((DocumentSnapshot documentSnapshot) {
                              if (documentSnapshot.exists) {
                                Map<String, dynamic> data = documentSnapshot
                                    .data()! as Map<String, dynamic>;
                                task = data['task'];
                              } else {
                                print(
                                    'Document does not exist on the database');
                              }
                            });

                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid)
                                .collection('project')
                                .doc(_projectId)
                                .update({
                              'task': task + 1,
                            });
                            setState(() {
                              disable = true;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        "New Task",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: SvgPicture.asset(
              AppImages.prevIcon,
              color: Colors.white,
            ), // Put icon of your preference.
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  Future<void> openProjectDialog(User user, Function press) async =>
      await showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('project')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;
                return SimpleDialog(
                  backgroundColor: Color(0xFFF4F4F4),
                  contentPadding: EdgeInsets.all(0),
                  children: [
                    for (int i = 0; i < data.length; i++)
                      SimpleDialogOption(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data[i]['title'].toString(),
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kColorNote[data[i]['color']],
                            ),
                          ),
                        ),
                        onPressed: () {
                          press(data[i]['title'].toString(),
                              data[i]['id'].toString());
                          Navigator.pop(context);
                        },
                      ),
                  ],
                );
              }
              return Container(
                color: Colors.white,
                child: Center(
                  child: Image.asset("assets/images/loader.gif"),
                ),
              );
            },
          );
        },
      );

  Future<void> openMemberDialog(Function press, List<String> _listUser) async =>
      await showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;
                return SimpleDialog(
                  backgroundColor: Color(0xFFF4F4F4),
                  contentPadding: EdgeInsets.all(0),
                  children: [
                    for (int i = 0; i < data.length; i++)
                      if (!_listUser.contains(data[i]['uid']))
                        SimpleDialogOption(
                          child: Row(
                            children: [
                              data[i]['avatar'] != ''
                                  ? CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                        data[i]['avatar'],
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                        "assets/images/none-avatar.png",
                                      ),
                                    ),
                              SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[i]['name']),
                                  Text(data[i]['email']),
                                ],
                              ),
                            ],
                          ),
                          onPressed: () {
                            press(data[i]['uid']);
                            Navigator.pop(context);
                          },
                        ),
                  ],
                );
              }
              return Container(
                color: Colors.white,
                child: Center(
                  child: Image.asset("assets/images/loader.gif"),
                ),
              );
            },
          );
        },
      );
}
