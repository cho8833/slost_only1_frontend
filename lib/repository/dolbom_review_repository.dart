import 'package:slost_only1/model/dolbom_review.dart';

abstract interface class DolbomReviewRepository {
  Future<DolbomReview?> getReview(int dolbomId);
  Future<DolbomReview> addReview(DolbomReviewCreateReq req);
}