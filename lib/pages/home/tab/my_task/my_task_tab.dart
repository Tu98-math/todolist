import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/base/base_state.dart';
import '/pages/home/tab/my_task/my_task_vm.dart';
import '/util/extension/widget_extension.dart';
import 'my_task_provider.dart';

class MyTaskTab extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return MyTaskTab._(watch);
    });
  }

  const MyTaskTab._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return MyTaskState();
  }
}

class MyTaskState extends BaseState<MyTaskTab, MyTaskViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: 'My Task'.desc(),
      ),
    );
  }

  @override
  MyTaskViewModel getVm() => widget.watch(viewModelProvider).state;
}
