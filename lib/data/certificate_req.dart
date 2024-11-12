import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/provider/certificate_provider.dart';
import 'package:slost_only1/support/custom_exception.dart';

part 'certificate_req.g.dart';

@JsonSerializable(createFactory: false)
class CreateCertificateReq {
  String title;

  CreateCertificateReq(this.title);

  Map<String, dynamic> toJson() => _$CreateCertificateReqToJson(this);

  factory CreateCertificateReq.from(CreateCertificateContext context) {
    if (context.title == null) {
      throw TypeException(message: "자격증 이름을 입력해주세요");
    }
    return CreateCertificateReq(context.title!);
  }}