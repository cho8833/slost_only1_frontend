import 'package:slost_only1/data/dolbom_review_req.dart';
import 'package:slost_only1/model/dolbom_review.dart';
import 'package:slost_only1/support/server_response.dart';

abstract interface class DolbomReviewRepository {
  Future<DolbomReview?> getReview(int dolbomId);
  Future<DolbomReview> addReview(DolbomReviewCreateReq req);
  Future<PagedData<DolbomReview>> getMyReview(int page);
  Future<void> reportReview(ReportDolbomReviewReq req);
}