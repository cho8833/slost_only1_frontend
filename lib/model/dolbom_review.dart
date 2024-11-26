import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1/enums/review_report_reason.dart';

part 'dolbom_review.g.dart';

@JsonSerializable()
class DolbomReview {
  int id;
  String content;
  int star;
  int dolbomId;
  String? reportContent;
  ReviewReportReason? reportReason;

  DolbomReview(this.id, this.content, this.star, this.dolbomId);

  Map<String, dynamic> toJson() => _$DolbomReviewToJson(this);

  factory DolbomReview.fromJson(Map<String, dynamic> json) => _$DolbomReviewFromJson(json);
}

@JsonSerializable(createFactory: false)
class DolbomReviewCreateReq {
  String content;
  int star;
  int dolbomId;

  DolbomReviewCreateReq(this.content, this.star, this.dolbomId);
  Map<String, dynamic> toJson() => _$DolbomReviewCreateReqToJson(this);
}