import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/data/available_area_req.dart';
import 'package:slost_only1/enums/age.dart';
import 'package:slost_only1/enums/dolbom_category.dart';
import 'package:slost_only1/enums/gender.dart';

part 'teacher_profile_req.g.dart';

@JsonSerializable(createFactory: false)
class TeacherProfileCreateReq {
  String? name;
  Gender? gender;
  DateTime? birthday;
  String? profileName;

  int? pay;
  List<AvailableAreaCreateReq> availableArea = [];

  @JsonKey(includeToJson: false)
  XFile? profileImage;

  bool validateBaseInfo() {
    return name != null &&
        gender != null &&
        birthday != null &&
        profileName != null &&
        profileImage != null;
  }

  bool validateSecond() {
    return pay != null && availableArea.isNotEmpty;
  }

  Map<String, dynamic> toJson() => _$TeacherProfileCreateReqToJson(this);
}

@JsonSerializable(createFactory: false)
class TeacherProfileEditReq {
  String? introduce;
  String? howBecameTeacher;
  String? name;
  String? profileName;
  List<Age>? availableAge;
  List<DolbomCategory>? availableCategory;
  DateTime? birthday;
  Gender? gender;

  @JsonKey(includeToJson: false)
  XFile? profileImage;

  Map<String, dynamic> toJson() => _$TeacherProfileEditReqToJson(this);
}