import 'package:flutter/cupertino.dart';
import 'package:slost_only1/data/dolbom_req.dart';
import 'package:slost_only1/repository/dolbom_repository.dart';
import 'package:slost_only1/widget/dolbom/create_dolbom/create_dolbom_context.dart';
import 'package:status_builder/status_builder.dart';

class DolbomProvider {
  DolbomProvider(this.dolbomRepository);

  final DolbomRepository dolbomRepository;

  ValueNotifier<Status> postDolbomStatus = ValueNotifier(Status.idle);

  Future<void> postDolbom(CreateDolbomContext createContext) async {
    postDolbomStatus.value = Status.loading;

    await dolbomRepository.postDolbom(PostDolbomReq.from(createContext)).then((_) {

      postDolbomStatus.value = Status.success;
    });
  }
}