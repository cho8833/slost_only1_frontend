// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dolbom_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DolbomReview _$DolbomReviewFromJson(Map<String, dynamic> json) => DolbomReview(
      (json['id'] as num).toInt(),
      json['content'] as String,
      (json['star'] as num).toInt(),
      (json['dolbomId'] as num).toInt(),
    )
      ..reportContent = json['reportContent'] as String?
      ..reportReason = json['reportReason'] == null
          ? null
          : ReviewReportReason.fromJson(json['reportReason'] as String);

Map<String, dynamic> _$DolbomReviewToJson(DolbomReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'star': instance.star,
      'dolbomId': instance.dolbomId,
      'reportContent': instance.reportContent,
      'reportReason': instance.reportReason,
    };

Map<String, dynamic> _$DolbomReviewCreateReqToJson(
        DolbomReviewCreateReq instance) =>
    <String, dynamic>{
      'content': instance.content,
      'star': instance.star,
      'dolbomId': instance.dolbomId,
    };
