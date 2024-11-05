import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/model/address.dart';
import 'package:slost_only1/model/member.dart';

part 'dolbom_location.g.dart';

@JsonSerializable()
class DolbomLocation {
  int id;
  Member member;
  Address address;

  DolbomLocation(this.id, this.member, this.address);

  factory DolbomLocation.fromJson(Map<String, dynamic> json) => _$DolbomLocationFromJson(json);

}