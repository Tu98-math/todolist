import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

import 'info_card.dart';
import 'list_count_task_card.dart';
import 'statistic_card.dart';

class ProfilesBody extends StatefulWidget {
  const ProfilesBody({Key? key}) : super(key: key);

  @override
  _ProfilesBodyState createState() => _ProfilesBodyState();
}

class _ProfilesBodyState extends State<ProfilesBody> {
  final User? user = FirebaseAuth.instance.currentUser;
  int _event = 0, _task = 0, _quickNote = 0;
  int _eventComple = 0, _taskComple = 0, _quickNoteComple = 0;

  Future<void> loadData() async {
    int taskLength = 0;
    int taskCompleLength = 0;
    await FirebaseFirestore.instance.collection('project').get().then((snap) {
      for (int i = 0; i < snap.docs.length; i++) {
        final listID = snap.docs.asMap()[i]!['member'];
        listID.add(snap.docs.asMap()[i]!['for']);
        if (listID.contains(user!.uid)) {
          taskLength++;
          if (snap.docs.asMap()[i]!['status'] == 1) {
            taskCompleLength++;
          }
        }
      } // will return the collection size
    });
    setState(() {
      _task = taskLength;
      _taskComple = taskCompleLength;
    });

    int quickNoteLength = 0,
        eventLength = 0,
        quickNoteCompleLength = 0,
        eventCompleLength = 0;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('quick_note')
        .get()
        .then((snap) {
      for (int i = 0; i < snap.docs.length; i++) {
        if (snap.docs.asMap()[i]!['list'] == true) {
          eventLength += int.parse(snap.docs.asMap()[i]!['length'].toString());
          for (int j = 0; j < snap.docs.asMap()[i]!['length']; j++) {
            if (snap.docs.asMap()[i]!['checked$j'] == true) {
              eventCompleLength++;
            }
          }
        } else {
          quickNoteLength++;
          if (snap.docs.asMap()[i]!['status'] == 1) {
            quickNoteCompleLength++;
          }
        }
      } // will return the collection size
    });
    setState(() {
      _event = eventLength;
      _quickNote = quickNoteLength;
      _eventComple = eventCompleLength;
      _quickNoteComple = quickNoteCompleLength;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(),
              SizedBox(height: 8),
              ListCountTaskCard(
                event: _event,
                task: _task,
                quickNote: _quickNote,
              ),
              StatisticCard(
                event: _event != 0 ? _eventComple / (_event * 1.0) : 0,
                toDo: _task != 0 ? _taskComple / (_task * 1.0) : 0,
                quickNote:
                    _quickNote != 0 ? _quickNoteComple / (_quickNote * 1.0) : 0,
              ),
              SizedBox(height: 160)
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "Profiles",
        style: TextStyle(
          fontFamily: 'AvenirNextRoundedPro',
          fontWeight: FontWeight.bold,
          color: AppColors.kText,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
