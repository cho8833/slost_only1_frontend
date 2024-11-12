import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/enums/gender.dart';

class TeacherProfileCreateReq {
  String? name;
  Gender? gender;
  DateTime? birthday;
  String? profileName;

  @JsonKey(includeToJson: false)
  XFile? profileImage;

  bool validate() {
    return name != null &&
        gender != null &&
        birthday != null &&
        profileName != null &&
        profileImage != null;
  }
}
