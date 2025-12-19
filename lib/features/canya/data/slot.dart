class Slot {
  final String? id;
  final String comments;
  final DateTime when;

  Slot({this.id, this.comments = '', required this.when});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'comments': this.comments,
      'when': this.when,
    };
  }

  factory Slot.fromMap(Map<String, dynamic> map) {
    return Slot(
      id: map['id'] as String,
      comments: map['comments'] as String,
      when: DateTime.parse(map['when'] as String),
      // when: map['when'] as DateTime,
    );
  }
}
