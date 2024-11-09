import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/model/address.dart';

part 'dolbom_location_req.g.dart';

@JsonSerializable(createFactory: false)
class DolbomLocationCreateReq {
  Address address;

  String name;

  DolbomLocationCreateReq(this.address, this.name);


  Map<String, dynamic> toJson() => _$DolbomLocationCreateReqToJson(this);

}