class CanyaEvent {
  final String? id;
  final String name;
  final String? description;

  CanyaEvent({
    this.id,
    required this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory CanyaEvent.fromMap(Map<String, dynamic> map) {
    return CanyaEvent(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }
}
