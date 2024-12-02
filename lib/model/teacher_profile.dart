import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/enums/age.dart';
import 'package:slost_only1/enums/dolbom_category.dart';
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
  String introduce;
  String howBecameTeacher;

  TeacherProfile(this.id, this.name, this.gender, this.profileImageUrl,
      this.birthday, this.profileName, this.introduce, this.howBecameTeacher);

  factory TeacherProfile.fromJson(Map<String, dynamic> json) => _$TeacherProfileFromJson(json);
}

@JsonSerializable()
class MyTeacherProfile {
  int id;
  String? name;
  Gender? gender;
  String? profileImageUrl;
  DateTime? birthday;
  String? profileName;
  String? introduce;
  String? howBecameTeacher;
  List<Age>? availableAge;
  List<DolbomCategory>? availableCategory;


  MyTeacherProfile(
      this.id,
      this.name,
      this.gender,
      this.profileImageUrl,
      this.birthday,
      this.profileName,
      this.introduce,
      this.howBecameTeacher,
      this.availableAge,
      this.availableCategory);

  factory MyTeacherProfile.fromJson(Map<String, dynamic> json) => _$MyTeacherProfileFromJson(json);
}