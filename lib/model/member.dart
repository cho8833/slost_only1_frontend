import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/enums/member_role.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  int id;
  String? phoneNumber;
  String? email;
  MemberRole role;
  String sendbirdAccessToken;


  Member(this.id, this.phoneNumber, this.role, this.sendbirdAccessToken);

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  String getSendbirdId() {
    return role.json + id.toString();
  }
}