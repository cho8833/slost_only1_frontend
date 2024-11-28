import 'package:json_annotation/json_annotation.dart';

part 'certificate.g.dart';

@JsonSerializable()
class Certificate {

  int id;

  String title;

  String? fileUrl;

  Certificate(this.id, this.title);

  factory Certificate.fromJson(Map<String, dynamic> json) => _$CertificateFromJson(json);
}