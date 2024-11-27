import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/enums/review_report_reason.dart';

part 'dolbom_review_req.g.dart';

@JsonSerializable(createFactory: false)
class ReportDolbomReviewReq {
  String? content;
  ReviewReportReason reason;
  int reviewId;

  ReportDolbomReviewReq(this.content, this.reason, this.reviewId);

  Map<String, dynamic> toJson() => _$ReportDolbomReviewReqToJson(this);
}