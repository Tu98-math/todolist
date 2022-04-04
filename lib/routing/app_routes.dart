abstract class AppRoutes {
  // WELCOME
  static const WELCOME = '/welcome';

  // SPLASH
  static const SPLASH = '/splash';

  // AUTH
  static const AUTH = '/auth';
  static const PATH_SIGN_IN = '/sign_in';
  static const SIGN_IN = AUTH + PATH_SIGN_IN;
  static const PATH_SIGN_UP = '/sign_up';
  static const SIGN_UP = AUTH + PATH_SIGN_UP;
  static const PATH_FORGOT_PASSWORD = '/forgot_password';
  static const FORGOT_PASSWORD = AUTH + PATH_FORGOT_PASSWORD;
  static const PATH_RESET_PASSWORD = '/reset_password';
  static const RESET_PASSWORD = AUTH + PATH_RESET_PASSWORD;
  static const PATH_SUCCESSFUL = '/successful';
  static const SUCCESSFUL = AUTH + PATH_SUCCESSFUL;

  // HOME
  static const HOME = '/home';
  static const PATH_MY_TASK = '/my_task';
  static const MY_TASK = HOME + PATH_MY_TASK;
  static const PATH_MENU = '/menu';
  static const MENU = HOME + PATH_MENU;
  static const PATH_QUICK = '/quick';
  static const QUICK = HOME + PATH_QUICK;
  static const PATH_PROFILE = '/profile';
  static const PROFILE = HOME + PATH_PROFILE;
  static const PATH_NEW_TASK = '/new_task';
  static const NEW_TASK = HOME + PATH_NEW_TASK;
  static const PATH_ADD_NOTE = '/add_note';
  static const ADD_NOTE = HOME + PATH_ADD_NOTE;
  static const PATH_ADD_CHECK_LIST = '/add_check_list';
  static const ADD_CHECK_LIST = HOME + PATH_ADD_CHECK_LIST;

  static const String logInRoute = '/logInScreen';
  static const String signUpRoutes = '/signUpRoutes';
  static const String forgotPasswordRoute = '/forgotPasswordScreen';
  static const String resetPasswordRoute = '/resetPasswordScreen';
  static const String succesfulScreen = '/succesfulScreen';
  static const String workListScreen = '/workListScreen';
  static const String newTaskScreen = '/newTaskScreen';
  static const String newNoteScreen = '/newNoteScreen';
  static const String newCheckListScreen = '/newCheckListScreen';
}
