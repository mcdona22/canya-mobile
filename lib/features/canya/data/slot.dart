import 'package:freezed_annotation/freezed_annotation.dart';

part 'slot.freezed.dart';
part 'slot.g.dart';

@freezed
abstract class Slot with _$Slot {
  const Slot._();

  const factory Slot({
    String? id,
    String? canyaId,
    @Default('') String comments,
    required DateTime when,
  }) = _Slot;

  // Slot({
  //   this.id,
  //   this.canyaId,
  //   this.comments = '',
  //   required this.when,
  // });

  factory Slot.fromJson(Map<String, dynamic> json) =>
      _$SlotFromJson(json);

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': this.id,
  //     'canyaId': this.canyaId,
  //     'comments': this.comments,
  //     'when': this.when,
  //   };
  // }

  // factory Slot.fromMap(Map<String, dynamic> map) {
  //   return Slot(
  //     id: map['id'] as String,
  //     canyaId: map['canyaId'],
  //     comments: map['comments'] as String,
  //     when: DateTime.parse(map['when'] as String),
  //   );
  // }
  //
  // @override
  // String toString() {
  //   return 'Slot{id: $id, canyaId: $canyaId, comments: '
  //       '$comments, '
  //       'when: $when}';
  // }
}
