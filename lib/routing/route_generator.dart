import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/pages/forgot_password_screen.dart';
import '/pages/new_check_list_screen/new_check_list_screen.dart';
import '/pages/new_note_screen.dart';
import '/pages/new_task_screen/new_task_screen.dart';
import '/pages/reset_password_screen.dart';
import '/pages/sign_up_screen/sign_up_screen.dart';
import '/pages/succesful_screen.dart';
import '/pages/walkthrough_screen/walk_through_screen.dart';
import '/pages/welcome/welcome_screen.dart';
import '/pages/worklist_screen/work_list_screen.dart';
import '../pages/log_in_screen/login_screen.dart';
import 'routes.dart';

class RouteGenerator {
  static RouteGenerator? _instance;

  RouteGenerator._();

  factory RouteGenerator() {
    _instance ??= RouteGenerator._();
    return _instance!;
  }

  Route<dynamic> onGenerateRoute(RouteSettings setting) {
    final uri = Uri.parse(setting.name!);
    GetPageRoute page({required Widget child}) {
      return GetPageRoute(
          settings: setting, page: () => child, transition: Transition.fadeIn);
    }

    switch (setting.name) {
      // case Routes.homeRoute:
      //   return MaterialPageRoute(builder: (_) => MyHomePage());
      case Routes.welcome:
        return MaterialPageRoute(builder: (_) => WelcomeScreen.instance());
      case Routes.walkThroughRoute:
        return MaterialPageRoute(builder: (_) => WalkThroughScreen.instance());
      case Routes.logInRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen.instance());
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

class RouteException implements Exception {
  final String message;

  const RouteException(this.message);
}
