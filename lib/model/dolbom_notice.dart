import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/model/dolbom_location.dart';
import 'package:slost_only1/model/enums/category.dart';
import 'package:slost_only1/model/kid.dart';
import 'package:slost_only1/model/member.dart';

part 'dolbom_notice.g.dart';

@JsonSerializable()
class DolbomNotice {
  int id;
  int pay;
  DateTime startDateTime;
  DateTime endDateTime;
  Member member;
  List<Kid> kid;
  DolbomLocation dolbomLocation;
  DolbomCategory category;

  DolbomNotice(this.id, this.pay, this.startDateTime, this.endDateTime,
      this.member, this.kid, this.dolbomLocation, this.category);


  factory DolbomNotice.fromJson(Map<String, dynamic> json) => _$DolbomNoticeFromJson(json);
}