import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/routing/routes.dart';

class AddNewButton extends StatelessWidget {
  const AddNewButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => showAddDialog(context),
      child: Container(
        margin: EdgeInsets.only(top: 40),
        width: size.width * .15,
        height: size.width * .15,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(56),
        ),
        child: Center(
          child: Text(
            "+",
            style: TextStyle( 
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void showAddDialog(BuildContext context) => showDialog(
        barrierColor: AppColors.kBarrierColor,
        context: context,
        builder: (context) => SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding: EdgeInsets.all(0),
          children: <Widget>[
            SimpleDialogOption(
              padding: EdgeInsets.all(0),
              child: CreateItem(
                text: "Add Task",
                press: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.newTaskScreen);
                },
              ),
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(0),
              child: CreateItem(
                text: "Add Quick Note",
                press: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.newNoteScreen);
                },
              ),
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(0),
              child: CreateItem(
                text: "Add Check List",
                press: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.newCheckListScreen);
                },
              ),
            ),
          ],
        ),
      );
}

class CreateItem extends StatelessWidget {
  const CreateItem({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 268,
      height: 71,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFE4E4E4).withOpacity(.4),
        ),
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: () => press(),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.kTextColor,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
