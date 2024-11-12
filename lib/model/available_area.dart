import 'package:json_annotation/json_annotation.dart';

part 'available_area.g.dart';

@JsonSerializable()
class AvailableArea {
  int id;
  String sido;
  String sigungu;

  AvailableArea(this.id, this.sido, this.sigungu);


  factory AvailableArea.fromJson(Map<String, dynamic> json) => _$AvailableAreaFromJson(json);
}