import 'slot.dart';

class CanyaEvent {
  final String? id;
  final String name;
  final String? description;
  final List<Slot> slots;

  CanyaEvent({
    this.id,
    required this.name,
    this.description,
    this.slots = const [],
  });

  Map<String, dynamic> toTableMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'slots': slots,
    };
  }

  factory CanyaEvent.fromMap(Map<String, dynamic> dataMap) {
    // logInfo('JSON for the CanyaEvent : ', dataMap);
    final slots = (dataMap['slots']) as List? ?? [];
    return CanyaEvent(
      id: dataMap['id'] as String,
      name: dataMap['name'] as String,
      description: dataMap['description'] as String,
      slots: slots
          .map((json) => Slot.fromMap(json))
          .toList(),
      // slots: (map['slots'] as List?)
      //   ?map( (json) => Slot.fromMap(json))
    );
  }

  @override
  String toString() {
    return 'CanyaEvent {id: $id, name: $name, '
        'description: $description, slots: $slots}';
  }
}
