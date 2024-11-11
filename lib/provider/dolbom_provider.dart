import 'package:flutter/cupertino.dart';
import 'package:slost_only1/data/dolbom_req.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/enums/dolbom_status.dart';
import 'package:slost_only1/repository/dolbom_repository.dart';
import 'package:slost_only1/support/server_response.dart';
import 'package:slost_only1/widget/dolbom/create_dolbom/create_dolbom_context.dart';
import 'package:status_builder/status_builder.dart';

class DolbomProvider {
  DolbomProvider(this.dolbomRepository);

  final DolbomRepository dolbomRepository;

  ValueNotifier<Status> getMyDolbomStatus = ValueNotifier(Status.loading);
  String getMyDolbomErrorMessage = "";
  PagedData<Dolbom>? myDolboms;


  ValueNotifier<Status> postDolbomStatus = ValueNotifier(Status.idle);

  Future<void> postDolbom(CreateDolbomContext createContext) async {
    postDolbomStatus.value = Status.loading;

    await dolbomRepository.postDolbom(PostDolbomReq.from(createContext)).then((_) {

      postDolbomStatus.value = Status.success;
    });
  }

  Future<void> getMyDolbom(DolbomStatus status) async {

    getMyDolbomStatus.value = Status.loading;
    await dolbomRepository.getMyDolbom(DolbomListReq(status: status)).then((pagedData) {
      myDolboms = pagedData;

      getMyDolbomStatus.value = Status.success;
    }).catchError((e) {
      getMyDolbomStatus.value = Status.fail;
      getMyDolbomErrorMessage = e.toString();
    });
  }
}