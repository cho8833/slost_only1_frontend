import 'package:json_annotation/json_annotation.dart';

part 'dolbom_review.g.dart';

@JsonSerializable()
class DolbomReview {
  int id;
  String content;
  int star;


  DolbomReview(this.id, this.content, this.star);

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