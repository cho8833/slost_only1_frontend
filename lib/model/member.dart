import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  int id;
  String name;
  String phoneNumber;


  Member(this.id, this.name, this.phoneNumber);

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}