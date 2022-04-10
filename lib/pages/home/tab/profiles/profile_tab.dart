import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:to_do_list/widgets/avatar.dart';

import '/base/base_state.dart';
import '/constants/app_colors.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import 'profile_provider.dart';
import 'profile_vm.dart';

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
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 10),
            color: AppColors.kBoxShadow,
            blurRadius: 8.0,
          )
        ],
      ),
      child: StreamBuilder<infoStatus>(
        stream: getVm().bsInfoStatus,
        builder: (context, snapshot) {
          if (snapshot.data == infoStatus.setting) {
            return SettingCard(
              press: () => getVm().changeInfoStatus(infoStatus.info),
            );
          }
          return ProfileInfo(
            user: getVm().user!,
            press: () => getVm().changeInfoStatus(infoStatus.setting),
          );
        },
      ),
    ).pad(0, 16);
  }

  Widget buildSetting() {
    return Container();
  }

  @override
  ProfileViewModel getVm() => widget.watch(viewModelProvider).state;
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
    required this.user,
    required this.press,
  }) : super(key: key);

  final User user;

  final Function press;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(
          avatarLink: user.photoURL,
          sizeAvatar: 64.w,
        ).pad(23, 10, 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user.displayName
                  .toString()
                  .plain()
                  .fSize(18)
                  .lHeight(21.09)
                  .color(AppColors.kText)
                  .weight(FontWeight.w600)
                  .lines(1)
                  .overflow(TextOverflow.ellipsis)
                  .b(),
              user.email
                  .toString()
                  .plain()
                  .fSize(16)
                  .lHeight(19.7)
                  .color(AppColors.kGrayTextB)
                  .lines(1)
                  .overflow(TextOverflow.ellipsis)
                  .b(),
            ],
          ).pad(0, 0, 35),
        ),
        Icon(Icons.settings).pad(10).inkTap(
              onTap: press,
              borderRadius: BorderRadius.circular(100),
            ),
      ],
    );
  }
}

class SettingCard extends StatefulWidget {
  const SettingCard({
    Key? key,
    required this.press,
  }) : super(key: key);

  final Function press;

  @override
  State<SettingCard> createState() => _SettingCardState();
}

class _SettingCardState extends State<SettingCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            'Language'
                .plain()
                .fSize(18)
                .weight(FontWeight.w600)
                .b()
                .pad(15, 0, 10),
            Icon(Icons.person).pad(10).inkTap(
                  onTap: widget.press,
                  borderRadius: BorderRadius.circular(100),
                ),
          ],
        ),
        SizedBox(height: 5.w),
        Row(
          children: [
            'Vietnamese'
                .plain()
                .fSize(14)
                .color(AppColors.grayText)
                .weight(FontWeight.w400)
                .b()
                .pad(2, 5)
                .inkTap(
                  onTap: () async {
                    EasyLocalization.of(context)?.setLocale(Locale('vi', 'VN'));

                    print(context.locale);
                  },
                  borderRadius: BorderRadius.circular(5),
                ),
            SizedBox(width: 20.w),
            'English'
                .plain()
                .fSize(14)
                .weight(FontWeight.w500)
                .b()
                .pad(2, 5)
                .inkTap(
                  onTap: () {
                    Get.updateLocale(Locale('en', 'US'));
                  },
                  borderRadius: BorderRadius.circular(5),
                ),
          ],
        ).pad(10, 0, 0),
      ],
    );
  }
}
