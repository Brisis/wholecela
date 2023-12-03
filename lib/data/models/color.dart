import 'dart:convert';

import 'package:equatable/equatable.dart';

class ColorModel extends Equatable {
  final String id;
  final String name;
  final String hexCode;

  const ColorModel({
    required this.id,
    required this.name,
    required this.hexCode,
  });

  String toRawJson() => json.encode(toJson());

  ColorModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        hexCode = json["hexCode"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "hexCode": hexCode,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        hexCode,
      ];

  @override
  bool? get stringify => true;
}
