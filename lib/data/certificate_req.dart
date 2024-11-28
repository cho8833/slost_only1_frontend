import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'certificate_req.g.dart';

@JsonSerializable(createFactory: false)
class CreateCertificateReq {
  String title;

  @JsonKey(includeToJson: false)
  File? file;

  CreateCertificateReq(this.title, this.file);

  Map<String, dynamic> toJson() => _$CreateCertificateReqToJson(this);
}