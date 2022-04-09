import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do_list/constants/images.dart';
import 'package:to_do_list/routing/app_routes.dart';
import 'package:to_do_list/widgets/sign_in_content.dart';

class SuccesfulScreen extends StatefulWidget {
  const SuccesfulScreen({Key? key}) : super(key: key);

  @override
  _SuccesfulScreenState createState() => _SuccesfulScreenState();
}

class _SuccesfulScreenState extends State<SuccesfulScreen> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 4), (_timer) {
      Navigator.pushNamed(context, AppRoutes.logInRoute);
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.imgSuccessful),
            SignInContent(
              title: "Succesful!",
              content:
                  "You have succesfully change password. Please use your new passwords when logging in.",
            )
          ],
        ),
      ),
    ));
  }
}
