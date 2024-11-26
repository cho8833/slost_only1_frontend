import 'package:flutter/cupertino.dart';
import 'package:slost_only1/model/dolbom_review.dart';
import 'package:slost_only1/repository/dolbom_review_repository.dart';
import 'package:slost_only1/support/custom_exception.dart';
import 'package:slost_only1/support/server_response.dart';
import 'package:status_builder/status_builder.dart';

class DolbomReviewProvider {
  final DolbomReviewRepository dolbomReviewRepository;

  DolbomReviewProvider(this.dolbomReviewRepository);

  ValueNotifier<Status> addReviewStatus = ValueNotifier(Status.idle);

  DolbomReview? dolbomReview;
  ValueNotifier<Status> getDolbomReviewStatus = ValueNotifier(Status.loading);

  Future<void> getReview(int dolbomId) async {
    getDolbomReviewStatus.value = Status.loading;
    await dolbomReviewRepository.getReview(dolbomId).then((data) {
      dolbomReview = data;
      getDolbomReviewStatus.value = Status.success;
    }).catchError((e) {
      getDolbomReviewStatus.value = Status.fail;
    });
  }

  Future<DolbomReview> addReview(int dolbomId, double star, String content) async {
    if (!validateCreate(star, content)) {
      throw CustomException("평점을 입력해주세요");
    }
    DolbomReviewCreateReq req = DolbomReviewCreateReq(content, normalizeRating(star), dolbomId);
    addReviewStatus.value = Status.loading;
    return await dolbomReviewRepository.addReview(req).then((data) {
      addReviewStatus.value = Status.idle;
      getReview(dolbomId);
      return data;
    }).catchError((e) {
      addReviewStatus.value = Status.idle;
      throw e;
    });
  }

  Future<PagedData<DolbomReview>> getMyReviews(int page) {
    return dolbomReviewRepository.getMyReview(page);
  }

  bool validateCreate(double star, String content) {
    return star >= 1;
  }

  int normalizeRating(double star) {
    return (star * 10).toInt();
  }

  double denormalizeRating(int star) {
    return star.toDouble() / 10;
  }
}
