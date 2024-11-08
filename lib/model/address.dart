import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  String address;   // 경기 성남시 분당구 판교역로 166

  String sido;      // 경기

  String sigungu;   // 성남시 분당구

  String bname;     // 백현동

  String? details;

  Address(this.address, this.sido, this.sigungu, this.bname, this.details);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}