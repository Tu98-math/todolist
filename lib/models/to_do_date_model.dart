import 'package:equatable/equatable.dart';

class ToDoDateModel extends Equatable {
  final DateTime day;
  late final bool isTask;
  late final bool isMonth;
  ToDoDateModel({required this.day, this.isTask = true, this.isMonth = true});

  String toString() {
    return this.day.toString() +
        this.isTask.toString() +
        this.isMonth.toString();
  }

  @override
  List<Object?> get props => [day];
}
