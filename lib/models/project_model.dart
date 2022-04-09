import 'package:cloud_firestore/cloud_firestore.dart';

import '/base/base_state.dart';

class ProjectModel {
  final String? id;
  final String name;
  final String idAuthor;
  final int countTask;
  final int indexColor;
  final DateTime timeCreate;

  ProjectModel({
    this.id,
    required this.name,
    required this.idAuthor,
    required this.countTask,
    required this.indexColor,
    required this.timeCreate,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      idAuthor: json['id_author'],
      countTask: json['count_task'],
      indexColor: json['index_color'],
      timeCreate: DateFormat("yyyy-MM-dd hh:mm:ss").parse(
        json['time_create'],
      ),
    );
  }

  factory ProjectModel.fromFirestore(DocumentSnapshot doc) {
    return ProjectModel(
      id: doc.id,
      name: doc['name'],
      idAuthor: doc['id_author'],
      countTask: doc['count_task'],
      indexColor: doc['index_color'],
      timeCreate: DateFormat("yyyy-MM-dd hh:mm:ss").parse(
        doc['time_create'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'id_author': this.idAuthor,
        'count_task': this.countTask,
        'index_color': this.indexColor,
        'time_create':
            DateFormat("yyyy-MM-dd hh:mm:ss").format(this.timeCreate),
      };

  Map<String, dynamic> toFirestore() => {
        'name': this.name,
        'id_author': this.idAuthor,
        'count_task': this.countTask,
        'index_color': this.indexColor,
        'time_create':
            DateFormat("yyyy-MM-dd hh:mm:ss").format(this.timeCreate),
      };
}
