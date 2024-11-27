// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dolbom_review_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDolbomReviewReq _$ReportDolbomReviewReqFromJson(
        Map<String, dynamic> json) =>
    ReportDolbomReviewReq(
      json['content'] as String?,
      ReviewReportReason.fromJson(json['reason'] as String),
      (json['reviewId'] as num).toInt(),
    );

Map<String, dynamic> _$ReportDolbomReviewReqToJson(
        ReportDolbomReviewReq instance) =>
    <String, dynamic>{
      'content': instance.content,
      'reason': instance.reason,
      'reviewId': instance.reviewId,
    };
