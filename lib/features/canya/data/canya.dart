import 'package:freezed_annotation/freezed_annotation.dart';

part 'canya.freezed.dart';
part 'canya.g.dart';

@Freezed()
abstract class Canya with _$Canya {
  const factory Canya({
    String? id,
    required String name,
    required String? description,
    required String ownerId,
  }) =
      _Canya; // This maps the factory to the generated implementation

  factory Canya.fromJson(Map<String, dynamic> json) =>
      _$CanyaFromJson(json);
}
