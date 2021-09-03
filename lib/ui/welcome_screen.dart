import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/constants/images.dart';
import 'dart:async';

import 'package:to_do_list/routing/routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late final Future<FirebaseApp> _init;

  @override
  void initState() {
    super.initState();
    _init = Firebase.initializeApp();
    Timer.periodic(Duration(seconds: 4), (_timer) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
          Navigator.pushNamed(context, Routes.walkthroughRoute);
        } else {
          print('User is signed in!');
          Navigator.pushNamed(context, Routes.workListScreen);
        }
      });
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _init,
      builder: (context, snapshort) {
        if (snapshort.hasError) {
          return Center(
            child: Text('Error Connect'),
          );
        }
        if (snapshort.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.imgLogo,
                    width: size.width * .4,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "aking",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        BoxShadow(
                          offset: Offset(0, 4),
                          color: Colors.black.withOpacity(.25),
                          blurRadius: 8,
                        ),
                        BoxShadow(
                          offset: Offset(4, 0),
                          color: Colors.black.withOpacity(.25),
                          blurRadius: 8,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: Image.asset("assets/images/loader.gif"),
        );
      },
    );
  }
}
