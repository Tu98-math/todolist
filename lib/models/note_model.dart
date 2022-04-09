class NoteModel {
  final int id;
  final String text;
  bool check;

  NoteModel({required this.id, required this.text, this.check = true});
}
