class QuickNoteModel {
  final String id;
  final String content;
  final int indexColor;
  final int time;
  const QuickNoteModel({
    required this.content,
    required this.indexColor,
    required this.id,
    required this.time,
  });

  factory QuickNoteModel.fromJson(Map<String, dynamic> json) => QuickNoteModel(
        content: json['content'],
        indexColor: json['index_color'],
        id: json['id'],
        time: json['time'],
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'content': this.content,
        'index_color': this.indexColor,
        'time': this.time,
      };
}
