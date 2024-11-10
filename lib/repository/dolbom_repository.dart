import 'package:slost_only1/data/dolbom_req.dart';

abstract interface class DolbomRepository {
  Future<void> postDolbom(PostDolbomReq req);
}