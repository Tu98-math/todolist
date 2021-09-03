import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/models/quick_note_model.dart';

class QuickNoteCache {
  var _index = -1;

  static final List<QuickNote> _quickNote = [
  ];

  int get itemIndex => _index;
  List<QuickNote> get listItem => _quickNote;

  set setItemIndex(int index) {
    if (index >= 0 && index < _quickNote.length) {
      _index = index;
    }
  }

  QuickNoteCache(String uid) {
    _loadDataQuickNote(uid);
  }

  Future<void> _loadDataQuickNote(String uid) async {
    _quickNote.clear();
    await FirebaseFirestore.instance
    .collection('quick_note')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          //if (doc["id"] == uid) {
            QuickNote _note = new QuickNote(content: doc["content"], indexColor: int.parse(doc['color']));
            _quickNote.add(_note);
          //}
        });
    });
  }

  static UnmodifiableListView<QuickNote> get list =>
      UnmodifiableListView<QuickNote>(_quickNote);
}
