import '/base/base_view_model.dart';
import '/models/task_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class MyTaskViewModel extends BaseViewModel {
  BehaviorSubject<bool> bsIsToDay = BehaviorSubject<bool>.seeded(true);

  BehaviorSubject<List<TaskModel>>? bsListTask =
      BehaviorSubject<List<TaskModel>>();

  dynamic auth, fireStore, user;
  MyTaskViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
    user = ref.watch(authServicesProvider).currentUser();
    fireStore = ref.watch(firestoreServicesProvider);
    initListTaskData();
  }

  void initListTaskData() {
    fireStore.taskStream(user.uid).listen((event) {
      bsListTask!.add(event);
    });
  }

  setToDay(bool value) {
    bsIsToDay.add(value);
  }

  void signOut() {
    auth.signOut();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
