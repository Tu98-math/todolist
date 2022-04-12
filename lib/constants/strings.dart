import 'package:easy_localization/easy_localization.dart';

class AppStrings {
  /// [Welcome]
  static const String aking = 'aking';

  /// [Splash]
  static String getStarted = 'get_started'.tr();
  static String logIn = 'login'.tr();
  static List<String> splashTitle = [
    'welcome_to_aking'.tr(),
    'work_happens'.tr(),
    'tasks_and_assign'.tr(),
  ];
  static List<String> splashDes = [
    'whats_going_to_happen_tomorrow?'.tr(),
    'get_notified_when_work_happens'.tr(),
    'task_and_assign_them_to_colleagues'.tr(),
  ];

  /// [Sign In]
  static String welcomeBack = 'welcome_back'.tr();
  static String signInDes = 'sign_in_to_continue'.tr();
  static String username = 'username'.tr();
  static String usernameHint = 'enter_your_username'.tr();
  static String usernameValid = 'please_enter_a_email_address'.tr();
  static String password = 'password'.tr();
  static String passwordHint = 'enter_your_password'.tr();
  static String passwordValid = 'enter_more_than_6_char'.tr();
  static String forgotPassword = 'forgot_password'.tr();
  // login

  /// [Forgot Password]
  // forgotPassword
  static String forgotPasswordDes =
      'please_enter_your_email_below_to_receive_your_password_reset_instructions'
          .tr();

  static String sendRequest = 'send_request'.tr();
}
