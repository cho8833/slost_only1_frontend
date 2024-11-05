import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/model/dolbom_location.dart';
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
  Kid kid;
  DolbomLocation dolbomLocation;

  DolbomNotice(this.id, this.pay, this.startDateTime, this.endDateTime,
      this.member, this.kid, this.dolbomLocation);


  factory DolbomNotice.fromJson(Map<String, dynamic> json) => _$DolbomNoticeFromJson(json);
}