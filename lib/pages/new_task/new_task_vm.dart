import '/models/task_model.dart';
import '/services/fire_store_services.dart';

import '/base/base_view_model.dart';
import '/models/project_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class NewTaskViewModel extends BaseViewModel {
  dynamic auth, user;

  final AutoDisposeProviderReference ref;
  late final FirestoreService firestoreService;

  BehaviorSubject<List<ProjectModel>>? bsListProject =
      BehaviorSubject<List<ProjectModel>>();

  NewTaskViewModel(this.ref) {
    init();
  }

  void init() async {
    auth = ref.watch(authServicesProvider);
    user = auth.currentUser();
    firestoreService = ref.watch(firestoreServicesProvider);
    firestoreService.projectStream(user.uid).listen((event) {
      bsListProject!.add(event);
    });
  }

  Future<void> newTask(TaskModel task, ProjectModel project) async {
    startRunning();
    // add task to database
    String taskID = await firestoreService.addTask(task);
    // add task to project
    await firestoreService.addTaskProject(project, taskID);
    endRunning();
  }

  @override
  void dispose() {
    if (bsListProject != null) {
      bsListProject!.close();
    }

    super.dispose();
  }
}
