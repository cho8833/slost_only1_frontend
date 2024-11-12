import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/enums/gender.dart';

part 'teacher_profile.g.dart';


@JsonSerializable()
class TeacherProfile {
  int id;
  String name;
  Gender gender;
  String profileImageUrl;
  DateTime birthday;
  String profileName;

  TeacherProfile(this.id, this.name, this.gender, this.profileImageUrl,
      this.birthday, this.profileName);


  factory TeacherProfile.fromJson(Map<String, dynamic> json) => _$TeacherProfileFromJson(json);

}