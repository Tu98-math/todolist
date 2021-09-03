import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/ui/worklist_screen/components/menu_nav/project_card.dart';
import 'add_project_button.dart';

class MenuBody extends StatefulWidget {
  const MenuBody({Key? key}) : super(key: key);

  @override
  _MenuBodyState createState() => _MenuBodyState();
}

class _MenuBodyState extends State<MenuBody> {
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
    return Container(
      width: size.width,
      child: Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              user != null
                  ? Container(
                      width: size.width,
                      height: size.width,
                      child: StreamBuilder(
                          stream: users
                              .doc(user!.uid)
                              .collection('project')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              List<QueryDocumentSnapshot<Object?>> data =
                                  snapshot.data!.docs;
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    for (int i = 0; i < data.length / 2; i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            ProjectCard(
                                              title: data[i * 2]['title'],
                                              press: () {},
                                              task: data[i * 2]['task'],
                                              indexColor: data[i * 2]['color'],
                                            ),
                                            if (i * 2 + 1 < data.length)
                                              ProjectCard(
                                                title: data[i * 2 + 1]['title'],
                                                indexColor: data[i * 2 + 1]
                                                    ['color'],
                                                press: () {},
                                                task: data[i * 2]['task'],
                                              ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }
                            return Container(
                              color: Colors.white,
                              child: Center(
                                child: Image.asset("assets/images/loader.gif"),
                              ),
                            );
                          }),
                    )
                  : SizedBox(),
              AddProjectButton(),
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
        "Project",
        style: TextStyle(
            fontFamily: 'AvenirNextRoundedPro',
            fontWeight: FontWeight.bold,
            color: AppColors.kTextColor),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
