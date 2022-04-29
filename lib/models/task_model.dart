import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class TaskModel extends Equatable {
  final String id;
  final String idAuthor;
  final DocumentReference project;
  final String title;
  final String description;
  final DateTime dueDate, startDate;
  final List<DocumentReference> listMember;
  final DocumentReference author;

  TaskModel({
    this.id = '',
    required this.project,
    required this.idAuthor,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.startDate,
    required this.listMember,
    required this.author,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    List<DocumentReference> list = [];
    for (int i = 0; i < doc['member'].length; i++) {
      list.add(doc['member.user_$i']);
    }
    return TaskModel(
      id: doc.id,
      idAuthor: doc['id_author'],
      title: doc['title'],
      description: doc['description'],
      dueDate: DateFormat("yyyy-MM-dd hh:mm:ss").parse(doc['due_date']),
      startDate: DateFormat("yyyy-MM-dd hh:mm:ss").parse(doc['start_date']),
      project: doc['project'],
      listMember: list,
      author: doc['author'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'id_author': this.idAuthor,
        'title': this.title,
        'description': this.description,
        'due_date': DateFormat("yyyy-MM-dd hh:mm:ss").format(this.dueDate),
        'start_date': DateFormat("yyyy-MM-dd hh:mm:ss").format(this.startDate),
        'project': this.project,
        'member': {
          for (int i = 0; i < listMember.length; i++) 'user_$i': listMember[i],
        },
        'author': this.author,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
