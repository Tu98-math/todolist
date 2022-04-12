import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/pages/home/home_page.dart';

import '/pages/auth/sign_up/sign_up_page.dart';
import '/pages/new_task/new_task_screen.dart';
import '/pages/splash/splash_page.dart';
import '/pages/welcome/welcome_page.dart';
import '../pages/auth/forgot_password/forgot_password_screen.dart';
import '../pages/auth/reset_password_screen.dart';
import '../pages/auth/sign_in/sign_in_page.dart';
import '../pages/auth/succesful_screen.dart';
import '../pages/new_check_list/new_check_list_page.dart';
import '../pages/new_note/new_note_page.dart';
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
      case AppRoutes.WELCOME:
        return page(child: WelcomePage.instance());
      case AppRoutes.SPLASH:
        return page(child: SplashPage.instance());
      case AppRoutes.SIGN_IN:
        return page(child: SignInPage.instance());
      case AppRoutes.SIGN_UP:
        return page(child: SignUpPage.instance());
      case AppRoutes.HOME:
        return page(child: HomePage.instance());
      case AppRoutes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case AppRoutes.resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case AppRoutes.succesfulScreen:
        return MaterialPageRoute(builder: (_) => SuccesfulScreen());
      case AppRoutes.newTaskScreen:
        return MaterialPageRoute(builder: (_) => NewTaskScreen());
      case AppRoutes.NEW_NOTE:
        return page(child: NewNotePage.instance());
      case AppRoutes.NEW_CHECK_LIST:
        return page(child: NewCheckListPage.instance());
      default:
        throw RouteException("Route not found");
    }
  }
}

class RouteException implements Exception {
  final String message;

  const RouteException(this.message);
}
