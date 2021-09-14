import 'package:flutter/material.dart';
import 'package:to_do_list/ui/forgot_password_screen.dart';
import 'package:to_do_list/ui/log_in_screen/log_in_screen.dart';
import 'package:to_do_list/ui/new_check_list_screen/new_check_list_screen.dart';
import 'package:to_do_list/ui/new_note_screen.dart';
import 'package:to_do_list/ui/new_task_screen/new_task_screen.dart';
import 'package:to_do_list/ui/reset_password_screen.dart';
import 'package:to_do_list/ui/sign_up_screen/sign_up_screen.dart';
import 'package:to_do_list/ui/succesful_screen.dart';
import 'package:to_do_list/ui/walkthrough_screen/walkthrough_screen.dart';
import 'package:to_do_list/ui/welcome_screen.dart';
import 'package:to_do_list/ui/worklist_screen/work_list_screen.dart';
import 'package:to_do_list/utils/exceptions/route_exception.dart';

import 'routes.dart';

class RouteGenerator {
  static RouteGenerator? _instance;

  RouteGenerator._();

  factory RouteGenerator() {
    _instance ??= RouteGenerator._();
    return _instance!;
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.homeRoute:
      //   return MaterialPageRoute(builder: (_) => MyHomePage());
      case Routes.welcomeRoute:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case Routes.walkthroughRoute:
        return MaterialPageRoute(builder: (_) => WalkthroughScreen());
      case Routes.logInRoute:
        return MaterialPageRoute(builder: (_) => LogInScreen());
      case Routes.signUpRoutes:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case Routes.resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case Routes.succesfulScreen:
        return MaterialPageRoute(builder: (_) => SuccesfulScreen());
      case Routes.workListScreen:
        return MaterialPageRoute(builder: (_) => WorkListScreen());
      case Routes.newTaskScreen:
        return MaterialPageRoute(builder: (_) => NewTaskScreen());
      case Routes.newNoteScreen:
        return MaterialPageRoute(builder: (_) => NewNoteScreen());
      case Routes.newCheckListScreen:
        return MaterialPageRoute(builder: (_) => NewCheckListScreen());
      default:
        throw RouteException("Route not found");
    }
  }
}
