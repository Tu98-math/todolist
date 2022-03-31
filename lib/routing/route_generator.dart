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
import 'app_routes.dart';

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
      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => WelcomeScreen.instance());
      case AppRoutes.walkThroughRoute:
        return MaterialPageRoute(builder: (_) => WalkThroughScreen.instance());
      case AppRoutes.logInRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen.instance());
      case AppRoutes.signUpRoutes:
        return MaterialPageRoute(builder: (_) => SignUpScreen.instance());
      case AppRoutes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case AppRoutes.resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case AppRoutes.succesfulScreen:
        return MaterialPageRoute(builder: (_) => SuccesfulScreen());
      case AppRoutes.workListScreen:
        return MaterialPageRoute(builder: (_) => WorkListScreen());
      case AppRoutes.newTaskScreen:
        return MaterialPageRoute(builder: (_) => NewTaskScreen());
      case AppRoutes.newNoteScreen:
        return MaterialPageRoute(builder: (_) => NewNoteScreen());
      case AppRoutes.newCheckListScreen:
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
