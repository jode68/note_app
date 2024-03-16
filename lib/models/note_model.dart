class NoteModel {
  final String title;
  final String description;
  final String date;
  bool isComplete;

  NoteModel(
    this.title,
    this.description,
    this.date,
    this.isComplete,
  );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'date': date,
      'isComplete': isComplete,
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      json['title'] as String,
      json['description'] as String,
      json['date'] as String,
      json['isComplete'] as bool,
    );
  }
}
