import 'package:flutter/material.dart';
import 'package:to_do_list/routing/route_generator.dart';
import 'package:to_do_list/utils/theme/themes.dart';
import 'package:to_do_list/ui/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator().onGenerateRoute,
      theme: theme(),
      home: const WelcomeScreen(),
    );
  }
}
