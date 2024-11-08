import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/model/address.dart';


part 'dolbom_location.g.dart';

@JsonSerializable()
class DolbomLocation {
  int id;
  Address address;
  String name;

  DolbomLocation(this.id, this.address, this.name);

  factory DolbomLocation.fromJson(Map<String, dynamic> json) => _$DolbomLocationFromJson(json);

}