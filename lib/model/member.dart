import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  int id;
  String phoneNumber;


  Member(this.id, this.phoneNumber);

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}