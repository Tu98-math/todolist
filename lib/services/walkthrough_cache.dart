import 'dart:collection';

import 'package:to_do_list/constants/images.dart';
import 'package:to_do_list/models/walkthrough_model.dart';

class WalkthroughCache {
  var _index = -1;

  static final List<Walkthrough> _walkthrough = [
    Walkthrough(
      imageTop: AppImages.imgWalkthrough[0].toString(),
      title: "Welcome to aking",
      content: "Whats going to happen tomorrow?",
    ),
    Walkthrough(
      imageTop: AppImages.imgWalkthrough[1].toString(),
      title: "Work happens",
      content: "Get notified when work happens.",
    ),
    Walkthrough(
      imageTop: AppImages.imgWalkthrough[2].toString(),
      title: "Tasks and assign",
      content: "Task and assign them to colleagues.",
    ),
  ];

  int get itemIndex => _index;

  set setItemIndex(int index) {
    if (index >= 0 && index < _walkthrough.length) {
      _index = index;
    }
  }

  static UnmodifiableListView<Walkthrough> get list =>
      UnmodifiableListView<Walkthrough>(_walkthrough);
}
