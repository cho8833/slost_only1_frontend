import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/model/enums/gender.dart';

part 'kid_req.g.dart';

@JsonSerializable(createFactory: false)
class KidCreateReq {
  String name;

  DateTime birthday;

  Gender gender;

  String? tendency;

  String? remark;

  KidCreateReq(this.name, this.birthday, this.gender, this.tendency, this.remark);

  Map<String, dynamic> toJson() => _$KidCreateReqToJson(this);
}

@JsonSerializable(createFactory: false)
class KidEditReq {

  int id;

  String name;

  DateTime birthday;

  Gender gender;

  String? tendency;

  String? remark;

  KidEditReq(this.id, this.name, this.birthday, this.gender, this.tendency,
      this.remark);

  Map<String, dynamic> toJson() => _$KidEditReqToJson(this);


}