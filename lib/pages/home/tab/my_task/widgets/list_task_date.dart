import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/constants/constants.dart';
import 'package:to_do_list/constants/images.dart';
import 'package:to_do_list/widgets/avatar.dart';
import 'package:to_do_list/widgets/primary_button.dart';

class ListTaskDate extends StatelessWidget {
  const ListTaskDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WorkListDate(
            text:
                "Today, ${AppConstants.kMonthHeader[now.month - 1].substring(0, 3)} ${now.day}/${now.year}"),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('project').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;
              List<QueryDocumentSnapshot<Object?>> nowData = [];
              final User? user = FirebaseAuth.instance.currentUser;
              for (int i = 0; i < data.length; i++) {
                if (now.millisecondsSinceEpoch <
                        DateTime.parse(data[i]['date'].toString())
                            .millisecondsSinceEpoch &&
                    now.millisecondsSinceEpoch >
                        DateTime.parse(data[i]['create'].toString())
                            .millisecondsSinceEpoch) {
                  final listID = data[i]['member'];
                  listID.add(data[i]['for']);
                  if (listID.contains(user!.uid)) {
                    nowData.add(data[i]);
                  }
                }
              }
              return Column(
                children: <Widget>[
                  for (int i = 0; i < nowData.length; i++)
                    if (nowData[i]['status'] != -1)
                      MyTaskCard(
                        task: nowData[i]['title'].toString().length > 40
                            ? nowData[i]['title'].toString().substring(0, 40)
                            : nowData[i]['title'],
                        time: nowData[i]['time'],
                        checked: nowData[i]['status'] == 1,
                        idTask: nowData[i]['ID'].toString(),
                      ),
                  if (nowData.length == 0)
                    Center(
                      child: Text(
                        "Not task",
                      ),
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
        ),
        WorkListDate(
            text:
                "Tomorrow, ${AppConstants.kMonthHeader[tomorrow.month - 1].substring(0, 3)} ${tomorrow.day}/${tomorrow.year}"),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('project').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;
              List<QueryDocumentSnapshot<Object?>> tomorrowData = [];
              final User? user = FirebaseAuth.instance.currentUser;
              for (int i = 0; i < data.length; i++) {
                if (tomorrow.millisecondsSinceEpoch <
                        DateTime.parse(data[i]['date'].toString())
                            .millisecondsSinceEpoch &&
                    tomorrow.millisecondsSinceEpoch >
                        DateTime.parse(data[i]['create'].toString())
                            .millisecondsSinceEpoch) {
                  final listID = data[i]['member'];
                  listID.add(data[i]['for']);
                  if (listID.contains(user!.uid)) {
                    tomorrowData.add(data[i]);
                  }
                }
              }
              return Column(
                children: <Widget>[
                  for (int i = 0; i < tomorrowData.length; i++)
                    if (tomorrowData[i]['status'] != -1)
                      MyTaskCard(
                        task: tomorrowData[i]['title'].toString().length > 40
                            ? tomorrowData[i]['title']
                                .toString()
                                .substring(0, 40)
                            : tomorrowData[i]['title'],
                        time: tomorrowData[i]['time'],
                        checked: tomorrowData[i]['status'] == 1,
                        idTask: tomorrowData[i]['ID'].toString(),
                      ),
                  if (tomorrowData.length == 0)
                    Center(
                      child: Text(
                        "Not task",
                      ),
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
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class MyTaskCard extends StatelessWidget {
  const MyTaskCard({
    Key? key,
    required this.task,
    required this.time,
    required this.checked,
    required this.idTask,
  }) : super(key: key);

  final String task, time, idTask;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () => _showTaskDialog(context, task, idTask, time),
        child: Container(
          width: size.width,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 5),
                color: AppColors.kBoxShadow,
                blurRadius: 3,
              )
            ],
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SvgPicture.asset(
                  checked ? AppImages.checkTrueIcon : AppImages.checkFalseIcon,
                  width: 16,
                  height: 16,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    task,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      decoration: checked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: AppColors.kDarkTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      decoration: checked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  )
                ],
              ),
              Spacer(),
              Container(
                width: 4,
                height: 21,
                color: checked ? AppColors.kPrimaryColor : Color(0xFF6074F9),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showTaskDialog(
      BuildContext context, String title, String idTask, String time) async {
    return showDialog<void>(
      context: context, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(time),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.all(0),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _showTask(context, title, idTask, time);
              },
              child: Container(
                width: 60,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(5, 5),
                      color: Colors.black12,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset('assets/icons/edit.svg'),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                FirebaseFirestore.instance
                    .collection('project')
                    .doc(idTask)
                    .update({'status': -1});
              },
              child: Container(
                width: 60,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(5, 5),
                      color: Colors.black12,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset('assets/icons/delete.svg'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showTask(
      BuildContext context, String title, String idTask, String time) async {
    final User? user = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    String _inName = '', _name = '', _decription = '', _avatar = '';
    int _status = 1;
    bool _openComment = false;
    // ignore: unused_local_variable
    DateTime? dueDate = DateTime.now();
    List<String> _memberAvatar = [];
    List<String> _memberLinkAvatar = [];
    return showDialog<void>(
        context: context, // user must tap button!
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              void setAvatar(String link) {
                if (_avatar != link)
                  setState(() {
                    _avatar = link;
                  });
              }

              void setName(String name) {
                if (_name != name)
                  setState(() {
                    _name = name;
                  });
              }

              void openCmt() {
                setState(() {
                  _openComment = true;
                });
              }

              void setDueDate(String date) {
                if (date != '') {
                  DateTime? _dueDate = DateTime.parse(date);
                  if (_dueDate != dueDate)
                    setState(() {
                      dueDate = _dueDate;
                    });
                }
              }

              void setDecription(String decription) {
                if (_decription != decription)
                  setState(() {
                    _decription = decription;
                  });
              }

              void setInName(String name) {
                if (_inName != name)
                  setState(() {
                    _inName = name;
                  });
              }

              void setStatus(int check) {
                if (_status != check)
                  setState(() {
                    _status = check;
                  });
              }

              void setMemberAvatar(List<dynamic> listAvatar) {
                if (_memberLinkAvatar.length == 0) {
                  setState(() {
                    _memberLinkAvatar.clear();
                  });

                  for (int i = 0; i < listAvatar.length; i++) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(listAvatar[i])
                        .get()
                        .then((snap) {
                      if (snap.exists) {
                        Map<String, dynamic> data =
                            snap.data() as Map<String, dynamic>;
                        print(data['avatar']);
                        if (_memberLinkAvatar.contains(data['avatar']) == false)
                          setState(() {
                            _memberLinkAvatar.add(data['avatar']);
                          });
                      }
                    });
                  }
                  ;
                }
              }

              Future<void> setData(dataTask) async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(dataTask['for'])
                    .get()
                    .then((snap) {
                  if (snap.exists) {
                    Map<String, dynamic> data =
                        snap.data() as Map<String, dynamic>;
                    setAvatar(data['avatar']);
                    setName(data['name']);
                    setDueDate(dataTask['date']);
                    setDecription(dataTask['description']);
                    setMemberAvatar(dataTask['member']);
                    setInName(dataTask['inName']);
                    setStatus(dataTask['status']);
                  }
                });
              }

              return AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 0),
                title: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'x',
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset('assets/icons/setting.svg'),
                  ],
                ),
                titlePadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                content: Container(
                  width: size.width * .8,
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('project')
                              .doc(idTask)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<DocumentSnapshot> dc) {
                            if (dc.hasData) {
                              Map<String, dynamic> dataTask =
                                  dc.data!.data() as Map<String, dynamic>;
                              setData(dataTask);

                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                      InfoForTask(
                                        avatar: _avatar,
                                        name: _name,
                                      ),
                                      Line(),
                                      DueDateTask(dueDate: dueDate),
                                      Line(),
                                      DecriptionTask(decription: _decription),
                                      Line(),
                                      MemberTask(
                                        memberLinkAvatar: _memberLinkAvatar,
                                      ),
                                      Line(),
                                      TagTask(inName: _inName),
                                      SizedBox(height: 32),
                                      if (_status == 0)
                                        PrimaryButton(
                                          text: "Complete Task",
                                          press: () {
                                            FirebaseFirestore.instance
                                                .collection("project")
                                                .doc(idTask)
                                                .update({'status': 1});
                                            Navigator.pop(context);
                                          },
                                          backgroundColor: Color(0xFF6074F9),
                                        ),
                                      SizedBox(height: 30),
                                      Column(
                                        children: [
                                          Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Comment',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                InkWell(
                                                  onTap: () => openCmt(),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/open_comment.svg",
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
                      ],
                    ),
                  ),
                ),
                actionsPadding: EdgeInsets.all(0),
                actions: <Widget>[],
              );
            },
          );
        });
  }
}

class TagTask extends StatelessWidget {
  const TagTask({
    Key? key,
    required String inName,
  })  : _inName = inName,
        super(key: key);

  final String _inName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: SvgPicture.asset("assets/icons/tag_project.svg"),
        ),
        SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tag',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Container(
              width: 90,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xFFE8E8E8)),
              ),
              child: Center(
                child: Text(
                  _inName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class MemberTask extends StatelessWidget {
  const MemberTask({
    Key? key,
    required List<String> memberLinkAvatar,
  })  : _memberLinkAvatar = memberLinkAvatar,
        super(key: key);

  final List<String> _memberLinkAvatar;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: SvgPicture.asset("assets/icons/member.svg"),
        ),
        SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Members',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                for (int i = 0; i < _memberLinkAvatar.length; i++)
                  Avatar(
                    avatarLink: _memberLinkAvatar[i],
                    sizeAvatr: 16.0,
                    padding: 2.5,
                  )
              ],
            )
          ],
        ),
      ],
    );
  }
}

class DueDateTask extends StatelessWidget {
  const DueDateTask({
    Key? key,
    required this.dueDate,
  }) : super(key: key);

  final DateTime? dueDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: SvgPicture.asset("assets/icons/due_date.svg"),
        ),
        SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Due Date',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              "${AppConstants.kMonthHeader[dueDate!.month - 1].substring(0, 3)} ${dueDate!.day},${dueDate!.year}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DecriptionTask extends StatelessWidget {
  const DecriptionTask({
    Key? key,
    required this.decription,
  }) : super(key: key);

  final String decription;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: SvgPicture.asset("assets/icons/decription.svg"),
        ),
        SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Decription',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Container(
              child: Text(
                decription.length > 30
                    ? "$decription".substring(0, 30)
                    : "$decription",
                maxLines: 3,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Line extends StatelessWidget {
  const Line({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Container(
        height: 2,
        width: size.width,
        color: Color(0xFFE4E4E4),
      ),
    );
  }
}

class InfoForTask extends StatelessWidget {
  const InfoForTask({
    Key? key,
    required String avatar,
    required String name,
  })  : _avatar = avatar,
        _name = name,
        super(key: key);

  final String _avatar;
  final String _name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar(
          avatarLink: _avatar,
          sizeAvatr: 22,
        ),
        SizedBox(width: 10),
        Column(
          children: [
            Text(
              'Assigned to',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '$_name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class WorkListDate extends StatelessWidget {
  const WorkListDate({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 20,
        bottom: 2,
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }
}
