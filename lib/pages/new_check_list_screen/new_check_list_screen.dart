import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/constants/images.dart';
import 'package:to_do_list/widgets/choose_color_icon.dart';
import 'package:to_do_list/widgets/sign_in_button.dart';

import 'components/check_item.dart';

class NewCheckListScreen extends StatefulWidget {
  const NewCheckListScreen({Key? key}) : super(key: key);

  @override
  _NewCheckListScreenState createState() => _NewCheckListScreenState();
}

class _NewCheckListScreenState extends State<NewCheckListScreen> {
  int indexChooseColor = 0;
  int indexCheckItem = 4;
  void _setColor(int index) {
    setState(() {
      indexChooseColor = index;
    });
  }

  bool disable = true;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _descriptController = TextEditingController();
  List<TextEditingController> _listItemController = [
    for (int i = 0; i < 10; i++) TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            child: Container(
              height: size.height * .8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextFormField(
                            controller: _descriptController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                              hintStyle: TextStyle(
                                color: AppColors.kTextColor,
                              ),
                            ),
                            maxLines: 2,
                          ),
                          for (int i = 0; i < indexCheckItem; i++)
                            CheckItem(
                              index: i,
                              controller: _listItemController[i],
                            ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (indexCheckItem < 10) indexCheckItem++;
                                  });
                                },
                                child: Text(
                                  "+ Add new item",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (indexCheckItem > 1) indexCheckItem--;
                                  });
                                },
                                child: Text(
                                  "Remove item",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Choose Color",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 17,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (int i = 0; i < 5; i++)
                                  ChooseColorIcon(
                                    index: i,
                                    press: _setColor,
                                    tick: i == indexChooseColor,
                                  )
                              ],
                            ),
                          ),
                          SignInButton(
                            text: "Done",
                            disable: disable,
                            press: () {
                              setState(() {
                                disable = false;
                              });
                              if (_formKey.currentState!.validate()) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection("quick_note")
                                    .add({
                                  'task': _descriptController.text.trim(),
                                  'color': indexChooseColor,
                                  'time': DateTime.now(),
                                  'status': 0,
                                  'list': true,
                                  'length': indexCheckItem,
                                  for (int i = 0; i < indexCheckItem; i++)
                                    'item$i':
                                        _listItemController[i].text.trim(),
                                  for (int i = 0; i < indexCheckItem; i++)
                                    'checked$i': false,
                                });
                                setState(() {
                                  disable = true;
                                });
                                Navigator.pop(context);
                              }
                            },
                          ),
                          SizedBox(height: 220)
                        ],
                      ),
                    ),
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
        "New Check List",
        style: TextStyle(
            fontFamily: 'AvenirNextRoundedPro', fontWeight: FontWeight.bold),
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
}
