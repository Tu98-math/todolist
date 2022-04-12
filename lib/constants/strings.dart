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
  // forgotPassword [Sign In]
  static String forgotPasswordDes =
      'please_enter_your_email_below_to_receive_your_password_reset_instructions'
          .tr();
  // username [Sign In]
  static String sendRequest = 'send_request'.tr();

  /// [Reset Password]
  static String resetPassword = 'reset_password'.tr();
  static String resetPasswordDes =
      'reset_code_was_sent_to_your_phone_please_enter_the_code_and_create_new_password'
          .tr();
  static String resetCode = 'reset_code'.tr();
  static String enterYourNumber = 'enter_your_number'.tr();
  static String newPassword = 'new_password'.tr();
  // passwordHint [Sign In]
  static String confirmPassword = 'confirm_password'.tr();
  static String confirmPasswordHint = 'enter_your_confirm_password'.tr();
  static String changePassword = 'change_password'.tr();

  /// [Successful]
  static String successful = 'successful'.tr();
  static String successfulDes =
      'you_have_successfully_change_password_please_use_your_new_passwords_when_logging_in'
          .tr();

  /// [Home]
  static String myTask = 'my_task'.tr();
  static String menu = 'menu'.tr();
  static String quick = 'quick'.tr();
  static String profile = 'profile'.tr();

  /// [Home] [Add Button]
  static String addTask = 'add_task'.tr();
  static String addQuickNote = 'add_quick_note'.tr();
  static String addCheckList = 'add_check_list'.tr();

  /// [Home] [Add Button] [New Task]
  static String newTask = 'new_task'.tr();
  static String _in = 'in'.tr();
  // title [Home] [Menu] [Add Button]
  // description [Home] [My Task] [View Task]
  // dueDate [Home] [My Task] [View Task]
  static String anytime = 'anytime'.tr();
  static String addMember = 'add_member'.tr();
  static String anyone = 'anyone'.tr();
  // addTask [Home] [Add Button]

  /// [Home] [Add Button] [Add Note]
  static String addNote = 'add_note'.tr();
  // description [Home] [My Task] [View Task]
  // chooseColor [Home] [Menu] [Add Button]
  static String done = 'done'.tr();

  /// [Home] [Add Button] [Add Check List]
  // addCheckList [Home] [Add Button]
  // title [Home] [Menu] [Add Button]
  static String listItem(int id) => 'list_item'.tr(args: ['$id']);
  static String addNewItem = 'add_new_item'.tr();
  // chooseColor [Home] [Menu] [Add Button]
  // done [Home] [Add Button] [Add Note]

  /// [Home] [My Task]
  static String workList = 'work_list'.tr();
  static String today = 'today'.tr();
  static String month = 'month'.tr();

  /// [Home] [My Task] [Filter]
  static String incompleteTasks = 'incomplete_tasks'.tr();
  static String completedTasks = 'completed_tasks'.tr();
  static String allTasks = 'all_tasks'.tr();

  /// [Home] [My Task] [View Task]
  static String assignedTo = 'assigned_to'.tr();
  static String dueDate = 'due_date'.tr();
  static String description = 'description'.tr();
  static String members = 'members'.tr();
  static String tag = 'tag'.tr();
  static String completeTask = 'complete_task'.tr();
  static String comment = 'comment'.tr();
  static String commentHint = 'write_a_comment'.tr();
  static String send = 'send'.tr();

  /// [Home] [My Task] [View Task] [Edit]
  // addMember [Home] [Add Button] [New Task]
  static String deleteTask = 'delete_task'.tr();

  /// [Home] [Menu]
  static String projects = 'Projects'.tr();

  /// [Home] [Menu] [Add Button]
  static String title = 'Title'.tr();
  static String chooseColor = 'choose_color'.tr();

  /// [Home] [Quick]
  static String quickNotes = 'quick_notes'.tr();

  /// [Home] [Profile]
  static String profiles = 'profiles'.tr();
  static String createTasks = 'create_tasks'.tr();
  // completedTasks [Home] [My Task] [Filter]
  static String events = 'events'.tr();
  static String toDoTask = 'to_do_task'.tr();
  // quickNotes [Home] [Quick]
  static String statistic = 'statistic'.tr();
}
