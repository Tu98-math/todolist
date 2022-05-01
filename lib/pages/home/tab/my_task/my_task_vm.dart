import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list/models/meta_user_model.dart';
import '/models/to_do_date_model.dart';
import '/services/auth_services.dart';
import '/services/fire_store_services.dart';
import '/base/base_view_model.dart';
import '/models/task_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class MyTaskViewModel extends BaseViewModel {
  final AutoDisposeProviderReference ref;
  late final FirestoreService firestoreService;
  late final AuthenticationService auth;
  User? user;

  BehaviorSubject<bool> bsIsToDay = BehaviorSubject<bool>.seeded(true);
  BehaviorSubject<bool> bsFullMonth = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<List<TaskModel>>? bsListTask =
      BehaviorSubject<List<TaskModel>>();

  BehaviorSubject<List<ToDoDateModel>> bsToDoDate =
      BehaviorSubject<List<ToDoDateModel>>.seeded([]);

  MyTaskViewModel(this.ref) {
    initListDate();
    auth = ref.watch(authServicesProvider);
    user = auth.currentUser();
    firestoreService = ref.watch(firestoreServicesProvider);

    if (user != null) {
      firestoreService.taskStream(user!.uid).listen((event) {
        List<TaskModel> listAllData = event;
        List<TaskModel> listData = [];
        for (var task in listAllData) {
          if (task.idAuthor == user!.uid ||
              task.listMember.contains(user!.uid)) {
            listData.add(task);
            setTaskDate(task);
          }
        }
        listData.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        bsListTask!.add(listData);
      });
    }
  }

  void initListDate() {
    DateTime startDate = DateTime.now();
    DateTime endDate = startDate;

    while (DateTime.now().month == startDate.month || startDate.weekday != 1) {
      startDate = startDate.subtract(const Duration(days: 1));
    }

    print(startDate);

    while (DateTime.now().month == endDate.month || endDate.weekday != 7) {
      endDate = endDate.add(const Duration(days: 1));
    }

    List<ToDoDateModel> list = [];

    startDate = startDate.subtract(const Duration(days: 1));
    while (startDate != endDate) {
      startDate = startDate.add(const Duration(days: 1));
      list.add(
        new ToDoDateModel(
            day: startDate, isMonth: DateTime.now().month == startDate.month),
      );
    }
    bsToDoDate.add(list);
  }

  void setTaskDate(TaskModel task) {
    List<ToDoDateModel> list = bsToDoDate.value;
    for (ToDoDateModel taskDate in list) {
      if (task.dueDate.day == taskDate.day.day &&
          task.dueDate.month == taskDate.day.month &&
          task.dueDate.year == taskDate.day.year) {
        taskDate.isTask = true;
      }
    }
  }

  setToDay(bool value) {
    bsIsToDay.add(value);
  }

  setFullMonth(bool value) {
    bsFullMonth.add(value);
  }

  void signOut() {
    auth.signOut();
  }

  @override
  void dispose() {
    bsIsToDay.close();
    if (bsListTask != null) {
      bsListTask!.close();
    }
    super.dispose();
  }
}
