import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/assigned.dart';
import 'widgets/description.dart';
import 'widgets/tag.dart';
import '/models/meta_user_model.dart';
import '/models/project_model.dart';
import '/util/ui/common_widget/custom_avatar_loading_image.dart';
import '/widgets/primary_button.dart';
import '/constants/constants.dart';
import '/util/extension/extension.dart';
import '/models/task_model.dart';
import '/base/base_state.dart';
import 'detail_task_vm.dart';
import 'detail_task_provider.dart';
import 'widgets/due_date.dart';

class DetailTaskPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return DetailTaskPage._(watch);
    });
  }

  const DetailTaskPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return DetailTaskState();
  }
}

class DetailTaskState extends BaseState<DetailTaskPage, DetailTaskViewModel> {
  @override
  void initState() {
    super.initState();
    getVm().loadTask(Get.arguments);
    print(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppbar(),
      body: SingleChildScrollView(
        child: StreamBuilder<TaskModel?>(
          stream: getVm().bsTask,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return AppStrings.somethingWentWrong.text12().tr().center();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return AppStrings.loading.text12().tr().center();
            }
            TaskModel task = snapshot.data!;
            return buildBody(task);
          },
        ),
      ),
    );
  }

  Widget buildBody(TaskModel task) {
    return Column(
      children: [
        buildTitle(task.title),
        SizedBox(height: 24),
        buildAssigned(task.idAuthor),
        buildLine(),
        buildDueDate(task.dueDate),
        buildLine(),
        buildDescription(task.description),
        buildLine(),
        buildListMember(task.listMember),
        buildLine(),
        buildTag(task.idProject),
        SizedBox(height: 32.w),
        buildCompletedButton(
          task.completed,
          press: () => getVm().completedTask(task.id),
        )
      ],
    ).pad(0, 24);
  }

  Widget buildTitle(String title) => title.plain().fSize(18).lHeight(30).b();

  Widget buildAssigned(String id) {
    return StreamBuilder<MetaUserModel>(
      stream: getVm().getUser(id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return AppStrings.somethingWentWrong.text12().tr().center();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppStrings.loading.text12().tr().center();
        }

        MetaUserModel user = snapshot.data!;
        return Assigned(user: user);
      },
    );
  }

  Widget buildLine() => Container(
        color: AppColors.kLineColor,
        width: screenWidth,
        height: 2.w,
      ).pad(16, 0);

  Widget buildDueDate(DateTime dueDate) => DueDate(dueDate: dueDate);

  Widget buildDescription(String des) => Description(des: des);

  Widget buildListMember(List<String> listId) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 15.w),
          SizedBox(
            width: 18,
            height: 18,
            child: SvgPicture.asset(
              AppImages.memberIcon,
            ),
          ),
          SizedBox(width: 23.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppStrings.members
                    .plain()
                    .fSize(16)
                    .color(AppColors.kGrayTextA)
                    .b()
                    .tr(),
                SizedBox(height: 18.w),
                Row(
                  children: [
                    for (int i = 0;
                        i < (listId.length > 4 ? 4 : listId.length);
                        i++)
                      buildAvatarById(listId[i]).pad(0, 5, 0),
                    if (listId.length > 4)
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: '...'
                            .plain()
                            .color(Colors.white)
                            .weight(FontWeight.bold)
                            .b()
                            .pad(0, 0, 0, 6)
                            .center(),
                      )
                  ],
                )
              ],
            ),
          )
        ],
      );

  Widget buildTag(String projectId) => StreamBuilder<ProjectModel>(
      stream: getVm().getProject(projectId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return AppStrings.somethingWentWrong.text12().tr().center();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppStrings.loading.text12().tr().center();
        }
        ProjectModel project = snapshot.data!;
        return Tag(project: project);
      });

  Widget buildCompletedButton(bool isComleted, {required Function press}) {
    if (!isComleted)
      return PrimaryButton(
        text: AppStrings.completedTasks,
        backgroundColor: AppColors.kColorNote[0],
        press: press,
        disable: !onRunning,
      );
    else
      return PrimaryButton(
        text: AppStrings.completedTasks,
        backgroundColor: AppColors.kPrimaryColor,
        press: () {},
        disable: false,
      );
  }

  Widget buildAvatarById(String id) {
    return StreamBuilder<MetaUserModel>(
      stream: getVm().getUser(id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return AppStrings.somethingWentWrong.text12().tr().center();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppStrings.loading.text12().tr().center();
        }
        MetaUserModel user = snapshot.data!;
        return CustomAvatarLoadingImage(url: user.url ?? '', imageSize: 32);
      },
    );
  }

  AppBar buildAppbar() => ''
          .plainAppBar()
          .backgroundColor(Colors.white)
          .leading(
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close),
              color: Colors.black,
            ),
          )
          .actions(
        [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.settings),
            color: Colors.black,
          ),
        ],
      ).bAppBar();

  @override
  DetailTaskViewModel getVm() => widget.watch(viewModelProvider).state;
}
