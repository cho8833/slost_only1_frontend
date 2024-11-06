import 'package:json_annotation/json_annotation.dart';

part 'dolbom_notice_req.g.dart';

@JsonSerializable(createFactory: false)
class DolbomNoticeListReq {
  String? sido;

  String? sigungu;

  String? bname;

  int? pageNumber;

  DolbomNoticeListReq({this.sido, this.sigungu, this.bname, this.pageNumber});

  Map<String, dynamic> toJson() => _$DolbomNoticeListReqToJson(this);
}

@JsonSerializable(createFactory: false)
class DolbomNoticeCreateReq {
  DateTime startDateTime;
  DateTime endDateTime;
  int memberId;
  int dolbomLocationId;
  int kidId;
  int pay;

  DolbomNoticeCreateReq(this.startDateTime, this.endDateTime, this.memberId,
      this.dolbomLocationId, this.kidId, this.pay);


  Map<String, dynamic> toJson() => _$DolbomNoticeCreateReqToJson(this);
}