import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_list/constants/constants.dart';
import 'package:to_do_list/pages/home/tab/profiles/widgets/count_task_item.dart';
import 'package:to_do_list/pages/home/tab/profiles/widgets/statistic_item.dart';
import 'package:to_do_list/routing/app_routes.dart';

import '/base/base_state.dart';
import '/constants/app_colors.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import 'profile_provider.dart';
import 'profile_vm.dart';
import 'widgets/profile_info.dart';
import 'widgets/setting_card.dart';

class ProfileTab extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return ProfileTab._(watch);
    });
  }

  const ProfileTab._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends BaseState<ProfileTab, ProfileViewModel> {
  bool isToDay = true;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  int quickNoteLength = 0;
  int quickNoteSuccessfulLength = 0;

  int checkListLength = 0;
  int checkListSuccessfulLength = 0;

  Future<void> getImage(ImageSource source) async {
    var image = await _picker.pickImage(source: source);
    if (image != null) {}
  }

  @override
  void initState() {
    super.initState();
    initQuickNoteState();
  }

  void initQuickNoteState() {
    int check = 0;
    getVm().streamQuickNote().listen((event) {
      setState(() {
        quickNoteLength =
            event.where((element) => element.listNote.length == 0).length;
        quickNoteSuccessfulLength = event
            .where((element) =>
                ((element.listNote.length == 0) && (element.isSuccessful)))
            .length;

        checkListLength = event.length - quickNoteLength;

        checkListSuccessfulLength = event
            .where((element) =>
                ((element.listNote.length > 0) && (element.isSuccessful)))
            .length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContainer(),
      appBar: buildAppBar(),
    );
  }

  Widget buildContainer() {
    return Container(
      child: Container(
        color: Colors.white,
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.w),
              buildCardInfo(),
              SizedBox(height: 24.w),
              buildListCountTask(),
              SizedBox(height: 24.w),
              buildStatistic(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() => StringTranslateExtension('profiles')
      .tr()
      .plainAppBar(color: AppColors.kText)
      .backgroundColor(Colors.white)
      .bAppBar();

  Widget buildCardInfo() {
    return Container(
      width: screenWidth,
      height: 190.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Colors.white,
        boxShadow: AppConstants.kBoxShadow,
      ),
      child: StreamBuilder<infoStatus>(
        stream: getVm().bsInfoStatus,
        builder: (context, snapshot) {
          if (snapshot.data == infoStatus.setting) {
            return SettingCard(
              pressToProfile: () => getVm().changeInfoStatus(infoStatus.info),
              pressSignOut: () {
                getVm().signOut();
                Get.offAllNamed(AppRoutes.SIGN_IN);
              },
            );
          }
          return ProfileInfo(
            user: getVm().user!,
            press: () => getVm().changeInfoStatus(infoStatus.setting),
            createTask: quickNoteLength + checkListLength,
            completedTask:
                quickNoteSuccessfulLength + checkListSuccessfulLength,
          );
        },
      ),
    ).pad(0, 16);
  }

  Widget buildSetting() {
    return Container();
  }

  Widget buildListCountTask() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CountTaskItem(
            text: AppConstants.kStatisticTitle[0],
            task: 12,
          ).pad(0, 10, 0),
          CountTaskItem(
            text: AppConstants.kStatisticTitle[1],
            task: quickNoteLength,
            color: AppColors.kSplashColor[1],
          ).pad(0, 10, 0),
          CountTaskItem(
            text: AppConstants.kStatisticTitle[2],
            task: checkListLength,
            color: AppColors.kSplashColor[2],
          ),
        ],
      ).pad(20, 20, 0),
    );
  }

  Widget buildStatistic() {
    return Container(
      width: 343.w,
      height: 205.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
          boxShadow:AppConstants.kBoxShadow,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Statistic'
              .plain()
              .fSize(18)
              .lHeight(21.09)
              .weight(FontWeight.bold)
              .color(AppColors.kText)
              .b()
              .pad(0, 0, 16, 21),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatisticIcon(
                color: AppColors.kPrimaryColor,
                ratio: 12.88,
                title: AppConstants.kStatisticTitle[0],
              ),
              StatisticIcon(
                color: AppColors.kSplashColor[1],
                ratio: quickNoteSuccessfulLength == 0
                    ? 0
                    : quickNoteSuccessfulLength / quickNoteLength,
                title: AppConstants.kStatisticTitle[1],
              ),
              StatisticIcon(
                color: AppColors.kSplashColor[2],
                ratio: checkListSuccessfulLength == 0
                    ? 0
                    : checkListSuccessfulLength / checkListLength,
                title: AppConstants.kStatisticTitle[2],
              )
            ],
          )
        ],
      ).pad(0, 24),
    ).pad(0, 16);
  }

  @override
  ProfileViewModel getVm() => widget.watch(viewModelProvider).state;
}
