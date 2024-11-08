import 'package:flutter/cupertino.dart';
import 'package:slost_only1/data/dolbom_location_req.dart';
import 'package:slost_only1/model/dolbom_location.dart';
import 'package:slost_only1/repository/dolbom_location_repository.dart';
import 'package:status_builder/status_builder.dart';

class DolbomLocationProvider {

  List<DolbomLocation> myLocations = [];

  ValueNotifier<Status> getMyLocationStatus = ValueNotifier(Status.loading);
  String getMyLocationErrorMessage = "";

  ValueNotifier<Status> createLocationStatus = ValueNotifier(Status.loading);
  
  ValueNotifier<Status> deleteLocationStatus = ValueNotifier(Status.idle);

  final DolbomLocationRepository repository;

  DolbomLocationProvider(this.repository);


  Future<void> getMyLocations() async {
    getMyLocationStatus.value = Status.loading;
    await repository.getList().then((list) {
      myLocations = list;
      getMyLocationStatus.value = Status.success;
    }).catchError((e) {
      getMyLocationErrorMessage = e.toString();
      getMyLocationStatus.value = Status.fail;
    });
  }

  Future<void> addLocation(DolbomLocationCreateReq req) async {
    createLocationStatus.value = Status.loading;
    await repository.create(req).then((location) {
      getMyLocations();
      createLocationStatus.value = Status.success;
    });
  }
  
  Future<void> deleteLocation(int id) async {
    deleteLocationStatus.value = Status.loading;
    await repository.delete(id).then((_) {
      getMyLocations();
      deleteLocationStatus.value = Status.success;
    });
  }
}