import 'dart:collection';
import 'package:to_do_list/models/to_do_date_model.dart';

class ToDoDateCache {
  var _index = -1;


  static final List<ToDoDate> _toDoDate = [
    ToDoDate(day: 30, isMonth: false, isTask: true),
    ToDoDate(day: 31, isMonth: false),
    ToDoDate(day: 1, isTask: true),
    ToDoDate(day: 2),
    ToDoDate(day: 3),
    ToDoDate(day: 4),
    ToDoDate(day: 5),
    ToDoDate(day: 6, isTask: true),
    ToDoDate(day: 7, isTask: true),
    ToDoDate(day: 8),
    ToDoDate(day: 9),
    ToDoDate(day: 10),
    ToDoDate(day: 11),
    ToDoDate(day: 12),
    ToDoDate(day: 13),
    ToDoDate(day: 14, isTask: true),
    ToDoDate(day: 15, isTask: true),
    ToDoDate(day: 16),
    ToDoDate(day: 17),
    ToDoDate(day: 18),
    ToDoDate(day: 19),
    ToDoDate(day: 20),
    ToDoDate(day: 21),
    ToDoDate(day: 22, isTask: true),
    ToDoDate(day: 23),
    ToDoDate(day: 24),
    ToDoDate(day: 25),
    ToDoDate(day: 26),
    ToDoDate(day: 27),
    ToDoDate(day: 28),
    ToDoDate(day: 29),
    ToDoDate(day: 30),
    ToDoDate(day: 31, isTask: true),
    ToDoDate(day: 1, isMonth: false),
    ToDoDate(day: 2, isMonth: false),
  ];

  int get itemIndex => _index;

  set setItemIndex(int index) {
    if (index >= 0 && index < _toDoDate.length) {
      _index = index;
    }
  }

  static UnmodifiableListView<ToDoDate> get list =>
      UnmodifiableListView<ToDoDate>(_toDoDate);
}
