import 'package:slost_only1/data/dolbom_location_req.dart';
import 'package:slost_only1/model/dolbom_location.dart';

abstract interface class DolbomLocationRepository {
  Future<List<DolbomLocation>> getList();

  Future<DolbomLocation> create(DolbomLocationCreateReq req);
  
  Future<void> delete(int id);
}